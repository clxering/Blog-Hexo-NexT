---
title: Java 日期类型（Date、LocalDateTime、LocalDate、LocalTime）之间的转换
date: 2019-03-23 10:33:00
categories:
- 后端技术
tags:
- 综合
---

> 摘要：记录了 Java 日期类型（Date、LocalDateTime、LocalDate、LocalTime）之间的转换方式

<!-- more -->

## 需求
使用 TimerTask 实现定时循环执行某动作，指定起始时间点和频率。使用如下代码：

```
public static void timerTask() {
    new Timer().schedule(new TimerTask() {
        @Override
        public void run() {
            ……
        }
    }, new Date(), 1000);
}
```

注：若缺省 period 频率参数，如果date日期在今天之前，则启动定时器后，立即运行一次定时任务run方法；如果date日期在今天之后，则启动定时器后，会在指定的将来日期运行一次任务run方法。
若缺省 date 日期参数，指定启动定时器5s之后运行定时器任务run方法，并且只运行一次

date, 2000);
        /*如果指定的date时间是当天或者今天之前，启动定时器后会立即每隔2s运行一次定时器任务*/
        /*如果指定的date时间是未来的某天，启动定时器后会在未来的那天开始，每隔2s执行一次定时器任务*/

        5000, 2000);
        /*当启动定时器后，5s之后开始每隔2s执行一次定时器任务*/

## 问题描述
由于 schedule 用于指定起始时间点的构造仅支持传入 Date 类型，而 Date 类能够指定年、月、日、时、分、秒的构造已经标注 `@Deprecated`

```
public void schedule(TimerTask task, Date firstTime, long period) {
    if (period <= 0)
        throw new IllegalArgumentException("Non-positive period.");
    sched(task, firstTime.getTime(), -period);
}
```

```
@Deprecated
public Date(int year, int month, int date) {
    this(year, month, date, 0, 0, 0);
}

@Deprecated
public Date(int year, int month, int date, int hrs, int min) {
    this(year, month, date, hrs, min, 0);
}

@Deprecated
public Date(int year, int month, int date, int hrs, int min, int sec) {
    int y = year + 1900;
    // month is 0-based. So we have to normalize month to support Long.MAX_VALUE.
    if (month >= 12) {
        y += month / 12;
        month %= 12;
    } else if (month < 0) {
        y += CalendarUtils.floorDivide(month, 12);
        month = CalendarUtils.mod(month, 12);
    }
    BaseCalendar cal = getCalendarSystem(y);
    cdate = (BaseCalendar.Date) cal.newCalendarDate(TimeZone.getDefaultRef());
    cdate.setNormalizedDate(y, month + 1, date).setTimeOfDay(hrs, min, sec, 0);
    getTimeImpl();
    cdate = null;
}
```

## 解决方案
使用 LocalDateTime 结合 Instant 设定时间点后，转为 Date 类型：

```
//Sat Mar 23 09:57:43 CST 2019
LocalDateTime localDateTime = LocalDateTime.of(2019, 3, 23, 10, 18, 0);
ZoneId zone = ZoneId.systemDefault();
Instant instant = localDateTime.atZone(zone).toInstant();
Date date = Date.from(instant);
```

## 其他
### LocalDate 转为 Date
```
LocalDate localDate = LocalDate.now();
ZoneId zone = ZoneId.systemDefault();
Instant instant = localDate.atStartOfDay().atZone(zone).toInstant();
Date date = Date.from(instant);
```

### LocalTime 转为 Date
```
LocalTime localTime = LocalTime.now();
LocalDate localDate = LocalDate.now();
LocalDateTime localDateTime = LocalDateTime.of(localDate, localTime);
ZoneId zone = ZoneId.systemDefault();
Instant instant = localDateTime.atZone(zone).toInstant();
Date date = Date.from(instant);
```

### Date 转为 LocalDateTime
```
Date date = new Date();
Instant instant = date.toInstant();
ZoneId zone = ZoneId.systemDefault();
LocalDateTime localDateTime = LocalDateTime.ofInstant(instant, zone);
```

### Date 转为 LocalDate
```
Date date = new Date();
Instant instant = date.toInstant();
ZoneId zone = ZoneId.systemDefault();
LocalDateTime localDateTime = LocalDateTime.ofInstant(instant, zone);
LocalDate localDate = localDateTime.toLocalDate();
```

### Date 转为 LocalTime
```
Date date = new Date();
Instant instant = date.toInstant();
ZoneId zone = ZoneId.systemDefault();
LocalDateTime localDateTime = LocalDateTime.ofInstant(instant, zone);
LocalTime localTime = localDateTime.toLocalTime();
```
