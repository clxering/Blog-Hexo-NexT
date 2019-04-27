---
title: Collections.synchronizedList 涉及的集合并发问题
date: 2019-04-27 11:31:43
categories:
- 后端技术
tags:
- Java
---

> 摘要：记录使用 Collections.synchronizedList 时涉及并发问题的例子和解决方式。

<!-- more -->

## 问题描述
ArrayList 本身不是线程安全的，所以要通过集合 `Collections.synchronizedList` 将其转换为一个线程安全的类。两种容易产生错觉的错误等效实现如下：

```
class SyncList<E> {
    public List<E> list = Collections.synchronizedList(new ArrayList<E>());

    // 第一种
    public synchronized boolean putIfAbsent(E x) {
        boolean absent = !list.contains(x);
        if (absent)
            list.add(x);
        return absent;
    }

    // 第二种
    public boolean putIfAbsent(E x) {
        synchronized(this) {
            boolean absent = !list.contains(x);
            if (absent)
                list.add(x);
            return absent;
        }
    }
}
```

以上无论是哪一种实现，加的锁都是针对 SyncList 的实例对象，如果只有一个方法能够控制 list，从这个特定角度而言，确实也能够达到同步的要求，但是如果还有其他的方法或者方式能够控制 list（最简单的例子：`new SyncList<String>().list.add("Out of sync!");`），则会出现问题。因此使用上述方式并不能真正意义上实现线程安全性。

## 解决方案
正确的实现如下：

```
class SyncList<E> {
    public List<E> list = Collections.synchronizedList(new ArrayList<E>());

    public boolean putIfAbsent(E x) {
        synchronized (list) {
            boolean absent = !list.contains(x);
            if (absent)
                list.add(x);
            return absent;
        }
    }
}
```

Collections.synchronizedList 方法源码如下：

```
public static <T> List<T> synchronizedList(List<T> list) {
    return (list instanceof RandomAccess ?
        new SynchronizedRandomAccessList<T>(list) :
        new SynchronizedList<T>(list));
    }
```

通过源码，我们还需要知道 ArrayList 是否实现了 RandomAccess 接口：

```
public class ArrayList<E> extends AbstractList<E> implements List<E>, RandomAccess, Cloneable, java.io.Serializable  
```

查看 ArrayList 的源码，可以看到它实现了 RandomAccess，所以上面的 synchronizedList 放回的应该是 SynchronizedRandomAccessList 的实例。接下来看看 SynchronizedRandomAccessList 这个类的实现：

```
static class SynchronizedRandomAccessList<E>  extends SynchronizedList<E>  implements RandomAccess {  
    SynchronizedRandomAccessList(List<E> list) {  
        super(list);  
    }  

    SynchronizedRandomAccessList(List<E> list, Object mutex) {  
        super(list, mutex);  
    }  

    public List<E> subList(int fromIndex, int toIndex) {  
        synchronized(mutex) {  
            return new SynchronizedRandomAccessList<E>(list.subList(fromIndex, toIndex), mutex);  
        }  
    }  

    static final long serialVersionUID = 1530674583602358482L;  

    private Object writeReplace() {  
        return new SynchronizedList<E>(list);  
    }  
}  
```

因为 SynchronizedRandomAccessList 这个类继承自 SynchronizedList，而大部分方法都在 SynchronizedList 中实现了，所以源码中只包含了很少的方法，但是通过 subList 方法，我们可以看到这里使用的锁对象为 mutex 对象，而 mutex 是在 SynchronizedCollection 类中定义的，所以再看看 SynchronizedCollection 这个类中关于 mutex 的定义部分源码：

```
static class SynchronizedCollection<E> implements Collection<E>, Serializable {  
    private static final long serialVersionUID = 3053995032091335093L;  
    final Collection<E> c;  // Backing Collection  
    final Object mutex;     // Object on which to synchronize  

    SynchronizedCollection(Collection<E> c) {  
        if (c==null)  
            throw new NullPointerException();  
        this.c = c;  
            mutex = this;  
    }  

    SynchronizedCollection(Collection<E> c, Object mutex) {  
        this.c = c;  
            this.mutex = mutex;  
    }  
}  
```

可以看到 mutex 就是当前的 SynchronizedCollection 对象，而 SynchronizedRandomAccessList 继承自 SynchronizedList，SynchronizedList 又继承自 SynchronizedCollection，所以 SynchronizedRandomAccessList 中的 mutex 也就是 SynchronizedRandomAccessList 的 this 对象。所以在 SyncList 中使用的锁 list 对象，和 SynchronizedRandomAccessList 内部的锁是一致的，所以它可以实现线程安全性。
