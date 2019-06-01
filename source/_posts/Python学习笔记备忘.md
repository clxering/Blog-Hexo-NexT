---
title: Python 学习笔记备忘
date: 2019-04-26 17:24:49
categories:
- 后端技术
tags:
- python
---

> 摘要：记录 Python 的学习笔记，是阅读《Python编程：从入门到实践》、《Python编程快速上手  让繁琐工作自动化》、《Python学习手册(第4版)》以及《Python高级编程-第2版》之后，经过有机整合而成。

<!-- more -->

## 安装 jupyter
```
pip install jupyter
```
安装完成后，切换到 .ipynb 文件目录下，在命令行中执行 `jupyter notebook` 然后会在浏览器中打开目录。或者指定打开某个文件 `jupyter notebook notebook.ipynb`

## PEP 8 命名约定参考
- 尽量单独使用小写字母 l，大写字母 O 等容易混淆的字母。
- 模块命名尽量短小，使用全部小写的方式，可以使用下划线。
- 包命名尽量短小，使用全部小写的方式，不可以使用下划线。
- 类的命名使用 `CapWords` 的方式，模块内部使用的类采用 `_CapWords` 的方式。
- 异常命名使用 CapWords+Error 后缀的方式。
- 全局变量尽量只在模块内有效，类似 C 语言中的 static。实现方法有两种，一是 `__all__` 机制；其次是前缀加一个下划线。
- 函数命名使用全部小写的方式，可以使用下划线。
- 常量命名使用全部大写的方式，可以使用下划线。
- 类的属性（方法和变量）命名使用全部小写的方式，可以使用下划线。
- 类的属性有3种作用域 public、non-public 和 subclass API，可以理解成 C++ 中的 public、private、protected，non-public 属性前，前缀一条下划线。
- 类的属性若与关键字名字冲突，后缀一下划线，尽量不要使用缩略等其他方式。
- 为避免与子类属性命名冲突，在类的一些属性前，前缀两条下划线。比如：类 Foo 中声明 `__a`,访问时，只能通过 `Foo._Foo__a`，避免歧义。如果子类也叫 Foo，那就无能为力了。
- 类的方法第一个参数必须是 self，而静态方法第一个参数必须是 cls。

## title()
- 将字符串首字母转为大写后返回
- 例子：

```
name = "ada lovelace"
print(name.title())
# 输出 Ada Lovelace
```

- 其他转化方法，全部转为大写或小写：upper()、lower()

## 制表符和换行符
- `\n`，换行符
- `\t`，制表符

## 删除空白
- `rstrip()`，删除右边空白
- `lstrip()`，删除左边空白
- `strip()`，删除两端空白

## 正确地使用单引号和双引号
在用单引号括起的字符串中，如果包含撇号，就将导致错误。这是因为这会导致 Python 将第一个单引号和撇号之间的内容视为一个字符串，进而将余下的文本视为 Python 代码，从而引发错误。

```
message = "One of Python's strengths is its diverse community."
print(message)
# 撇号位于两个双引号之间，因此 Python 解释器能够正确地理解这个字符串：One of Python's strengths is its diverse community.
```
然而，如果你使用单引号，Python将无法正确地确定字符串的结束位置：

```
message = 'One of Python's strengths is its diverse community.'
print(message)
```

## 乘方运算
使用两个乘号表示乘方运算：

```
>>> 3 ** 2
9
>>> 3 ** 3
27
>>> 10 ** 6
1000000
```

## 浮点数结果包含的小数位数可能是不确定的

```
>>> 0.2 + 0.1
0.30000000000000004
>>> 3 * 0.1
0.30000000000000004
```
所有语言都存在这种问题，没有什么可担心的。Python 会尽力找到一种方式，以尽可能精确 地表示结果，但鉴于计算机内部表示数字的方式，这在有些情况下很难。

## str()
- 字符串转化
- 例子：

```
age = 23
message = "Happy " + str(age) + "rd Birthday!"
print(message)
```

## 列表
- 访问列表第一个元素

```
bicycles = ['trek', 'cannondale', 'redline', 'specialized']
print(bicycles[0])
```

- 访问列表最后一个元素

```
bicycles[-1]
```

- 添加元素到末尾

```
bicycles.append('ducati')
```

- 在第二个元素前插入元素

```
bicycles.insert(1, 'ducati')
```

- 使用 del 删除元素。注意：若列表有多个同名元素，以下语句仅删除第一次出现的元素。

```
del bicycles[0]
```

- 使用无参 pop() 删除元素，并返回被删除元素。类似栈，从最后一个元素开始删除。

```
popped_bicycles = bicycles.pop()
```

- 使用带参 pop() 删除指定元素，并返回被删除元素。

```
first_owned = motorcycles.pop(0)
```

- 根据值删除元素。注意：若列表有多个同名元素，以下语句仅删除第一次出现的元素。

```
motorcycles.remove('ducati')
```

- 使用 `sort()` 对列表按字母顺序进行永久性排序。对字符串排序时，使用 ASCII 字符顺序，而不是实际的字典顺序。这意味着大写字母排在小写字母之前。因此在排序时，小写的 a 在大写的 Z 之后。如果需要按照普通的字典顺序来排序，就在 sort() 方法调用时，将关键字参数 key 设置为 `str.lower`

```
cars = ['bmw', 'audi', 'toyota', 'subaru']
cars.sort()

>>> spam = ['a', 'z', 'A', 'Z']
>>> spam.sort(key=str.lower)
>>> spam
['a', 'A', 'z', 'Z']
```

- 使用 `sort(reverse=True)` 对列表按字母逆序进行永久性排序。

```
cars = ['bmw', 'audi', 'toyota', 'subaru']
cars.sort(reverse=True)
```

- 使用 `sorted()` 对列表进行临时排序，保留列表元素原来的排列顺序。`sorted()` 也可以传递参数 `reverse=True`。

```
cars = ['bmw', 'audi', 'toyota', 'subaru']
print(sorted(cars))
```

- 永久性逆序列表

```
cars = ['bmw', 'audi', 'toyota', 'subaru']
cars.reverse()
print(cars)
```

- 使用 `len()` 确定列表长度

```
>>> cars = ['bmw', 'audi', 'toyota', 'subaru']
>>> len(cars)
4
```

- 遍历列表

```
magicians = ['alice', 'david', 'carolina']
for magician in magicians:
    print(magician)
```

## 数值列表
- 使用 `range()` 数值序列或使用 `list(range(1,5))` 转为数值列表。需要注意输出的上界，例子：

```
for value in range(1,5):
    print(value)
# 输出 1，2，3，4
```

- 数值列表的统计计算

```
>>> digits = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
>>> min(digits)
0
>>> max(digits)
9
>>> sum(digits)
45
```

## 列表解析
- 创建平方数列表

```
squares = [value**2 for value in range(1,11)]
print(squares)
# 输出 [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```

## 列表切片
- 例子：

```
players = ['charles', 'martina', 'michael', 'florence', 'eli']
print(players[0:3])
# 输出 ['charles', 'martina', 'michael']
```

- 若缺省下界，则默认以起始位置作为下界；同理，若缺省上界，则默认以结束位置作为上界。
- 从最后开始取元素可以使用 `players[-3:]`，表示返回最后三个元素。

## 复制列表
即创建一个包含整个列表的切片，同时省略起始索引和终止索引（[:]）。

```
my_foods = ['pizza', 'falafel', 'carrot cake']
friend_foods = my_foods[:]
```

## 元组
元组是只读的，因此不能给元组的元素赋值，只能够改变元组的指向。

```
dimensions = (200, 50)
```

## 要判断两个值是否不等，可使用（!=）

```
requested_topping = 'mushrooms'
if requested_topping != 'anchovies':
    print("Hold the anchovies!")  
```

## 检查特定值是否包含在列表中

```
>>> requested_toppings = ['mushrooms', 'onions', 'pineapple']
>>> 'mushrooms' in requested_toppings
True
>>> 'pepperoni' in requested_toppings
False
```

## 检查特定值是否不包含在列表中

```
banned_users = ['andrew', 'carolina', 'david'] user = 'marie'  
if user not in banned_users:     
    print(user.title() + ", you can post a response if you wish.")
# 输出 Marie, you can post a response if you wish.
```

## 确定列表不是空的

```
requested_toppings = []

if requested_toppings:
    for requested_topping in requested_toppings:
        print("Adding " + requested_topping + ".")
        print("\nFinished making your pizza!")
    else:
        print("Are you sure you want a plain pizza?")
# 输出 Are you sure you want a plain pizza?
```

## 为字典添加键值对

```
alien_0 = {'color': 'green', 'points': 5}
alien_0['x_position'] = 0
alien_0['y_position'] = 25
print(alien_0)
# 输出 {'color': 'green', 'points': 5, 'y_position': 25, 'x_position': 0}
```

## 删除字典中的键值对

```
alien_0 = {'color': 'green', 'points': 5}
print(alien_0)
del alien_0['points']
```

## 遍历字典
- 遍历所有键值对

```
for key, value in user_0.items():
    print("\nKey: " + key)
    print("Value: " + value)
```

- 遍历所有键

```
for name in favorite_languages.keys():
    print(name.title())
```

遍历字典时，会默认遍历所有的键，因此，如果将上述代码中的 `for name in favorite_ languages.keys():` 替换为 `for name in favorite_languages:`，输出将不变。
- 按顺序遍所有键。要以特定的顺序返回元素，一种办法是在for循环中对返回的键进行排序。为此，可使用 `sorted()` 来获得按特定顺序排列的键列表的副本：

```
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
}

for name in sorted(favorite_languages.keys()):
    print(name.title() + ", thank you for taking the poll.")
```

- 遍历所有值

```
for language in favorite_languages.values():
    print(language.title())
```

这种做法提取字典中所有的值，而没有考虑是否重复。涉及的值很少时，这也许不是问题， 但如果被调查者很多，终的列表可能包含大量的重复项。为剔除重复项，可使用集合（set）。 集合类似于列表，但每个元素都必须是独一无二的：

```
for language in set(favorite_languages.values()):
    print(language.title())
```
注意：字典的 keys()、values()、items() 3 个方法返回的不是列表，而分别是 dict_keys、dict_values、dict_items 视图对象（view objects）

## 函数的位置实参、关键字实参
- 位置实参。必须将函数调用中的每个实参都关联到函数定义中的一个形参。为此，简单的关联方式是基于实参的顺序，这种关联方式被称为位置实参。位置实参的顺序很重要，如果实参的顺序不正确，结果可能出乎意料。
- 关键字实参是传递给函数的名称和值对。直接在实参中将名称和值关联起来了，因此向函数传递实参时不会混淆。关键字实参无需考虑函数调用中的实参顺序，还清楚地指出了函数调用中各个值的用途。

```
def describe_pet(animal_type, pet_name):
    print("\nI have a " + animal_type + ".")
    print("My " + animal_type + "'s name is " + pet_name.title() + ".")

# 演示关键字实参
describe_pet(animal_type='hamster', pet_name='harry')
```

## 函数默认值
使用默认值时，在形参列表中必须先列出没有默认值的形参，再列出有默认值的实参。这让 Python 依然能够正确地解读位置实参。

```
def describe_pet(pet_name, animal_type='dog'):
    """显示宠物的信息"""
    print("\nI have a " + animal_type + ".")
    print("My " + animal_type + "'s name is " + pet_name.title() + ".")

# 演示默认值
describe_pet(pet_name='willie')
```

## 让实参变成可选的
可给实参指定一个空字符串作为默认值，在用户没有提供值时则不使用这个实参。

```
def get_formatted_name(first_name, last_name, middle_name=''):
    """返回整洁的姓名"""
    if middle_name:
        full_name = first_name + ' ' + middle_name + ' ' + last_name
    else:
        full_name = first_name + ' ' + last_name
    return full_name.title()

musician = get_formatted_name('jimi', 'hendrix')
print(musician)

musician = get_formatted_name('john', 'hooker', 'lee')
print(musician)
```

## 禁止函数修改列表
向函数传递列表的副本而不是原件；这样函数所做的任何修改都只影响副本，而丝毫不影响原件。 格式如下：

```
function_name (list_name [:])
```
注意：虽然向函数传递列表的副本可保留原始列表的内容，但除非有充分的理由需要传递副本，否则还是应该将原始列表传递给函数，因为让函数使用现成列表可避免花时间和内存创建副本，从而提高效率，在处理大型列表时尤其如此。

## 传递任意数量的实参

```
def make_pizza(*toppings):
    """打印顾客点的所有配料"""
    for topping in toppings:
        print("- " + topping)

make_pizza('pepperoni')
make_pizza('mushrooms', 'green peppers', 'extra cheese')
```

## 使用任意数量的关键字实参
有时候，需要接受任意数量的实参，但预先不知道传递给函数的会是什么样的信息。在这种情况下，可将函数编写成能够接受任意数量的键值对，即调用语句提供了多少就接受多少。

```
def build_profile(first, last, **user_info):
    """形参 `**user_info` 中的两个星号让 Python 创建一个名为 user_info 的空字典，并将收到的所有名称值对都封装到这个字典中。"""
    profile = {}
    profile['first_name'] = first
    profile['last_name'] = last
    for key, value in user_info.items():
        profile[key] = value
        return profile

user_profile = build_profile('albert', 'einstein',location='princeton',field='physics')
print(user_profile)
```

## 导入整个模块
假设存在 pizza.py 文件，例子：

```
import pizza

pizza.make_pizza(16, 'pepperoni')
pizza.make_pizza(12, 'mushrooms', 'green peppers', 'extra cheese')
```

## 导入特定的函数或类
若使用这种语法，调用函数时就无需使用句点。格式：

```
from module_name import name
```

## 使用 as 给函数指定别名
例子：

```
from pizza import make_pizza as mp
```

## 导入模块中的所有函数

```
from pizza import *

make_pizza(16, 'pepperoni')
make_pizza(12, 'mushrooms', 'green peppers', 'extra cheese')
```
注意：使用并非自己编写的大型模块时，好不要采用这种导入方法，如果模块中有函数的名称与你的项目中使用的名称相同，可能导致意想不到的结果：Python 可能遇到多个名称相同的函数或变量，进而覆盖函数，而不是分别导入所有的函数。佳的做法是，要么只导入你需要使用的函数，要么导入整个模块并使用句点表示法。

## 方法__init__()
例子：

```
class Dog():
    """一次模拟小狗的简单尝试"""
    def __init__(self, name, age):
        """初始化属性name和age"""
        self.name = name
        self.age = age

def sit(self):
    """模拟小狗被命令时蹲下"""
    print(self.name.title() + " is now sitting.")

def roll_over(self):
    """模拟小狗被命令时打滚"""
    print(self.name.title() + " rolled over!")
```

类中的函数称为方法；方法 `__init__()` 定义成了包含三个形参：self、name 和 age。在这个方法的定义中，形参 self 必不可少，还必须位于其他形参的前面。Python调用这个 `__init__()` 方法来创建 Dog 实例时，将自动传入实参 self。每个与类相关联的方法 调用都自动传递实参 self，它是一个指向实例本身的引用，让实例能够访问类中的属性和方法。我们创建 Dog 实例时，Python 将调用 Dog 类的方法 `__init__()`。我们将通过实参向 Dog() 传递名字和年龄；self 会自动传递，因此我们不需要传递它。每当我们根据 Dog 类创建实例时，都只需给后两个形参（name 和 age）提供值。

## 根据类创建实例

```
my_dog = Dog('willie', 6)
```

## 给属性指定默认值
类中的每个属性都必须有初始值，哪怕这个值是 0 或空字符串。在有些情况下，如设置默认 值时，在方法 `__init__()` 内指定这种初始值是可行的；如果你对某个属性这样做了，就无需包含为它提供初始值的形参。

```
class Car():
    def __init__(self, make, model, year):
        """初始化描述汽车的属性"""
        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0
```

## 继承

```
class Car():
    """汽车类"""
    ……（略）

class ElectricCar(Car):
    """电动汽车的独特之处"""
    def __init__(self, make, model, year):
        """初始化父类的属性"""
        super().__init__(make, model, year)
```

## 重写父类的方法
可在子类中定义一个这样的方法，即它与要重写的父类方法同名。这样，Python 将不会考虑这个父类方法，而只关注你在子类中定义的相应方法。

## 使用标准库 OrderedDict
OrderedDict 实例的行为几乎与字典相同，区别只在于记录了键值对的添加顺序。

## 从文件中读取数据
- 读取整个文件

```
with open('pi_digits.txt') as file_object:
    contents = file_object.read()
    print(contents)
```

注意：关键字 with 在不再需要访问文件后将其关闭。让 Python 去确定关闭时机：你只管打开文件，并在需要时使用它。

- 逐行读取

```
filename = 'pi_digits.txt'

with open(filename) as file_object:
    for line in file_object:
        print(line)
```

## 写入文件
- 写入空文件

```

```

## 分析CSV 文件
- 获取文件头
csv 模块包含在 Python 标准库中，可用于分析 CSV 文件中的数据行。模块 csv 包含函数 next()，调用它并将阅读器对象传递给它时，它将返回文件中的下一行。调用了 next() 一次，因此得到的是文件的第一行，其中包含文件头。

```
import csv

filename = 'sitka_weather_07-2014.csv'

with open(filename) as f:
    reader = csv.reader(f)
    header_row = next(reader)

# 输出文件第一行
print(header_row)
```

- 打印文件头及其位置
对列表调用 `enumerate()` 来获取每个元素的索引及其值。用于判断每一行数据中，哪一列是需要的。

```
for index, column_header in enumerate(header_row):
	print(index, column_header)
```

- 提取并读取数据
遍历全部内容，取每一行的第 2 列存入列表。

```
highs = []

for row in reader:
	highs.append(row[1])

print(highs)
```

## 使用 int() 将字符串转换为数字值
（略）

## 使用 float() 将字符串转换为数字值
（略）

## request 包的使用
- 安装 request

```
$ pip install --user requests
```

- 找出GitHub上星级最高的Python项目

```
import requests

# 执行API调用并存储响应
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
r = requests.get(url)
print("Status code:", r.status_code)
# 将API响应存储在一个变量中?
response_dict = r.json()
# 处理结果
print(response_dict.keys())
```

- 监视API 的速率限制

## 「类真」和「类假」
数据类型中的某些值，条件认为它们等价于 True 或 False。在用于条件时，0、0.0、''（空字符串）被认为是 False，其他值被认为是 True。例子：
```
numList = []

if numList:
    print(len(numList))
else:
    print("no")
```

## range()
该方法最多传入 3 个参数：range(a,b,c)，取值范围 [a,b)，步长 c。例如：`numList = list(range(1, 11, 2))`，赋值 [1, 3, 5, 7, 9]

## 内建函数
- random
`random.randint()` 函数调用求值为传递给它的两个整数之间的一个随机整数。

```
import random
    for i in range(5):
    print(random.randint(1, 10))
```

- sys
调用 `sys.exit()` 函数，可以让程序终止或退出。

```
import sys

while True:
    print('Type exit to exit.')
    response = input()
    if response == 'exit':
        sys.exit()
    print('You typed ' + response + '.')
```

## None 值
在 Python 中有一个值称为 None，它表示没有值。None 是 NoneType 数据类型的唯一值（其他编程语言可能称这个值为 null、nil 或 undefined）。就像布尔值 True 和 False 一样，None 必须大写首字母 N。

在幕后，对于所有没有 return 语句的函数定义，Python 都会在末尾加上 return None。这类似于 while 或 for 循环隐式地以 continue 语句结尾。而且，如果使用不带值的 return 语句（也就是只有 return 关键字本身），那么就返回 None。

## global 语句
如果需要在一个函数内修改全局变量，就使用 global 语句。如果在函数的顶部有 global eggs 这样的代码，它就告诉 Python，在这个函数中，eggs 指的是全局变
量。

有 4 条法则，来区分一个变量是处于局部作用域还是全局作用域：
- 如果变量在全局作用域中使用（即在所有函数之外），它就总是全局变量。
- 如果在一个函数中，有针对该变量的global 语句，它就是全局变量。
- 否则，如果该变量用于函数中的赋值语句，它就是局部变量。
- 但是，如果该变量没有用在赋值语句中，它就是全局变量。

## 多重赋值
多重赋值技巧是一种快捷方式，让你在一行代码中，用列表（或元组）中的值为多个变量赋值。所以不必像这样：

```
>>> cat = ['fat', 'black', 'loud']
>>> size = cat[0]
>>> color = cat[1]
>>> disposition = cat[2]
```

而是输入下面的代码：

```
>>> size, color, disposition = ['fat', 'black', 'loud']
# 使用元组
>>> size, color, disposition = ('fat', 'black', 'loud')
```

变量的数目和列表的长度必须严格相等，否则 Python 将给出 ValueError

## 用 index() 方法在列表中查找值
可以传入一个值，如果该值存在于列表中，就返回它的下标。如果该值不在列表中，Python 就报 ValueError

## 用 append() 和 insert() 方法在列表中添加值
的 append() 方法将参数添加到列表末尾。insert() 方法可以在列表任意下标处插入一个值。insert() 方法的第一个参数是新值的下标，第二个参数是要插
入的新值。

## 用 list() 和 tuple() 函数来转换类型
函数 list() 和 tuple() 将返回传递给它们的值的列表和元组版本。

```
>>> tuple(['cat', 'dog', 5])
('cat', 'dog', 5)
>>> list(('cat', 'dog', 5))
['cat', 'dog', 5]
>>> list('hello')
['h', 'e', 'l', 'l', 'o']
```

## copy 模块的 copy() 和 deepcopy() 函数

```
import copy
spam = ['A', 'B', 'C', 'D']
cheese = copy.copy(spam)
cheese[1] = 42

>>> spam
['A', 'B', 'C', 'D']
>>> cheese
['A', 42, 'C', 'D']
```

如果要复制的列表中包含了列表，那就使用copy.deepcopy()函数来代替。deepcopy()函数将同时复制它们内部的列表。

```
import copy

numList = [1, 3, 5, [2, 6, 8]]

numList2 = copy.copy(numList)
numList2[3][0]="p"
print(numList)
print(numList2)

# 输出，此时 numList 也被修改
[1, 3, 5, ['p', 6, 8]]
[1, 3, 5, ['p', 6, 8]]
# 改为 numList2 = copy.deepcopy(numList)，则输出如下
[1, 3, 5, [2, 6, 8]]
[1, 3, 5, ['p', 6, 8]]
```

## get() 方法
在访问一个键的值之前，检查该键是否存在于字典中，可使用 get() 方法，它有两个参数：要取得其值的键，以及如果该键不存在时，返回的备用值。

```
>>> picnicItems = {'apples': 5, 'cups': 2}
>>> 'I am bringing ' + str(picnicItems.get('cups', 0)) + ' cups.'
'I am bringing 2 cups.'
>>> 'I am bringing ' + str(picnicItems.get('eggs', 0)) + ' eggs.'
'I am bringing 0 eggs.'
```

因为 picnicItems 字典中没有 'egg' 键，get() 方法返回的默认值是 0。不使用 get()，代码就会产生一个错误消息，就像下面的例子：

```
>>> picnicItems = {'apples': 5, 'cups': 2}
>>> 'I am bringing ' + str(picnicItems['eggs']) + ' eggs.'
Traceback (most recent call last):
File "<pyshell#34>", line 1, in <module>
'I am bringing ' + str(picnicItems['eggs']) + ' eggs.'
KeyError: 'eggs'
```

## setdefault() 方法
你常常需要为字典中某个键设置一个默认值，当该键没有任何值时使用它。代码看起来像这样：

```
spam = {'name': 'Pooka', 'age': 5}

if 'color' not in spam:
    spam['color'] = 'black'
```

setdefault() 方法提供了一种方式，在一行中完成这件事。传递给该方法的第一个参数，是要检查的键。第二个参数，是如果该键不存在时要设置的值。如果该键确实存在，方法就会返回键的值：

```
>>> spam = {'name': 'Pooka', 'age': 5}
>>> spam.setdefault('color', 'black')
'black'
>>> spam
{'color': 'black', 'age': 5, 'name': 'Pooka'}
>>> spam.setdefault('color', 'white')
'black'
>>> spam
{'color': 'black', 'age': 5, 'name': 'Pooka'}
```

setdefault() 方法是一个很好的快捷方式，可以确保一个键存在。下面有一个小程序，计算一个字符串中每个字符出现的次数。打开一个文件编辑器窗口，输入以下代码：

```
message = 'It was a bright cold day in April, and the clocks were striking thirteen.'
count = {}

for character in message:
    count.setdefault(character, 0)
    count[character] = count[character] + 1

print(count)
```

程序循环迭代 message 字符串中的每个字符，计算每个字符出现的次数。setdefault() 方法调用确保了键存在于count 字典中（默认值是 0），这样在执行 `count[character] =count[character] + 1` 时，就不会抛出 KeyError 错误。程序运行时，输出如下：

```
{' ': 13, ',': 1, '.': 1, 'A': 1, 'I': 1, 'a': 4, 'c': 3, 'b': 1, 'e': 5, 'd': 3, 'g': 2, 'i':
6, 'h': 3, 'k': 2, 'l': 3, 'o': 2, 'n': 4, 'p': 1, 's': 3, 'r': 5, 't': 6, 'w': 2, 'y': 1}
```

从输出可以看到，小写字母 c 出现了 3 次，空格字符出现了 13 次，大写字母 A 出现了 1 次。无论 message 变量中包含什么样的字符串，这个程序都能工作，即使该字符串有上百万的字符！

## 原始字符串
可以在字符串开始的引号之前加上 r，使它成为原始字符串。原始字符串完全忽略所有的转义字符，打印出字符串中所有的倒斜杠。

```
>>> print(r'That is Carol\'s cat.')
That is Carol\'s cat.
```

## 用三重引号的多行字符串
虽然可以用 \n 转义字符将换行放入一个字符串，但使用多行字符串通常更容易。在 Python 中，多行字符串的起止是 3 个单引号或 3 个双引号。三重引号之间的所有引号、制表符或换行，都被认为是字符串的一部分。Python 的代码块缩进规则不适用于多行字符串。

```
print('''Dear Alice,
Eve's cat has been arrested for catnapping, cat burglary, and extortion.
Sincerely,
Bob''')
```

## 多行注释
虽然井号字符（#）表示这一行是注释，但多行字符串常常用作多行注释。下面是完全有效的 Python 代码：

```
"""This is a test Python program.
Written by Al Sweigart al@inventwithpython.com
This program was designed for Python 3, not Python 2.
"""
def spam():
    """This is a multiline comment to help
    explain what the spam() function does."""
    print('Hello!')
```

## 字符串下标和切片
字符串像列表一样，使用下标和切片。可以将字符串 'Hello world!' 看成是一个列表，字符串中的每个字符都是一个表项，有对应的下标。

## 字符串的 in 和 not in 操作符
像列表一样，in 和 not in 操作符也可以用于字符串。用 in 或 not in 连接两个字符串得到的表达式，将求值为布尔值 True 或 False。

## 字符串方法 upper()、lower()、isupper() 和 islower()
upper() 和 lower() 字符串方法返回一个新字符串，其中原字符串的所有字母都被相应地转换为大写或小写。字符串中非字母字符保持不变。如果字符串至少有一个字母，并且所有字母都是大写或小写，isupper() 和 islower() 方法就会相应地返回布尔值 True。否则，该方法返回 False。

## isX 字符串方法
除了 islower() 和 isupper()，还有几个字符串方法，它们的名字以 is 开始。这些方法返回一个布尔值，描述了字符串的特点。下面是一些常用的 isX 字符串方法：
- isalpha() 返回 True，如果字符串只包含字母，并且非空；
- isalnum() 返回 True，如果字符串只包含字母和数字，并且非空；
- isdecimal() 返回 True，如果字符串只包含数字字符，并且非空；
- isspace() 返回 True，如果字符串只包含空格、制表符和换行，并且非空；
- istitle() 返回 True，如果字符串仅包含以大写字母开头、后面都是小写字母的单词。

## 字符串方法 startswith() 和 endswith()
startswith() 和 endswith() 方法返回 True，如果它们所调用的字符串以该方法传入的字符串开始或结束。否则，方法返回 False。

## 字符串方法 join() 和 split()
如果有一个字符串列表，需要将它们连接起来，成为一个单独的字符串，join() 方法就很有用。join() 方法在一个字符串上调用，参数是一个字符串列表，返回一个字符串。返回的字符串由传入的列表中每个字符串连接而成。

```
>>> ', '.join(['cats', 'rats', 'bats'])
'cats, rats, bats'
>>> ' '.join(['My', 'name', 'is', 'Simon'])
'My name is Simon'
>>> 'ABC'.join(['My', 'name', 'is', 'Simon'])
'MyABCnameABCisABCSimon'
```

join() 方法是针对一个字符串而调用的，并且传入一个列表值（很容易不小心用其他的方式调用它）。split()方法做的事情正好相反：它针对一个字符串调用，返回一个字符串列表。

```
>>> 'My name is Simon'.split()
['My', 'name', 'is', 'Simon']
>>> 'MyABCnameABCisABCSimon'.split('ABC')
['My', 'name', 'is', 'Simon']
>>> 'My name is Simon'.split('m')
['My na', 'e is Si', 'on']
```

## 用 rjust()、ljust() 和 center() 方法对齐文本
rjust() 和 ljust() 字符串方法返回调用它们的字符串的填充版本，通过插入空格来对齐文本。这两个方法的第一个参数是一个整数长度，用于对齐字符串。

## 用 pyperclip 模块拷贝粘贴字符串
pyperclip 模块有 copy() 和 paste() 函数，可以向计算机的剪贴板发送文本，或从它接收文本。将程序的输出发送到剪贴板，使它很容易粘贴到邮件、文字处理程序或其他软件中。但 pyperclip 模块不是 Python 自带的。

```
>>> import pyperclip
>>> pyperclip.copy('Hello world!')
>>> pyperclip.paste()
'Hello world!'
```

## numpy 使用
```
# 构造一个判断条件
mask = np.array([1, 1, 1, 0, 0], dtype=bool)
print(mask)
# 输出 [ True  True  True False False]
# 测试矩阵
array = np.array([1, 2, 3, 4, 5])
# 根据判断条件，用 True 所在位置的元素值重新返回一个矩阵，维数和原矩阵相同
result = array[mask]
print(result)
# 输出 [1 2 3]

# 筛选大于 3 的元素，返回一个在对应位置用布尔值代替的矩阵，满足条件为 True，反之 False
print(array > 3)
# 输出 [False False False  True  True]

# 查看大于 3 的元素所在位置，返回满足条件的索引组成的列表
print(np.where(array > 3))
# 输出 (array([3, 4], dtype=int32),)
# 查看值上述位置的具体值
print(array[np.where(array > 3)])

# 指定列表元素的数据类型
array = np.array([1, 2, 3, 4, 5], dtype=np.float64)
print(array.dtype)

# 复制列表
array2 = np.copy(array)
array2[1] = 99
print(array)
print(array2)
# 输出
# [1. 2. 3. 4. 5.]
# [ 1. 99.  3.  4.  5.]
```

```
# 取二维矩阵的元素
array = np.array([
    [1, 3, 5, 7],
    [2, 4, 6, 8],
    [10, 11, 12, 13]
])
# 取单个元素
print(array[1, 2])
# 输出 6
# 取整个行
print(array[1])
# 输出 [2 4 6 8]
# 取列
print(array[:, 3])
# 输出 [ 7  8 13]

# 填充数值
array.fill(1)
print(array)
# 输出
"""
[[1 1 1 1]
 [1 1 1 1]
 [1 1 1 1]]
"""
# 返回维数
print(array.ndim)
# 输出 2

# 返回元素总个数
print(array.size)
# 输出 12
# 或者使用 np
print(np.size(array))
# 输出 12

# 根据元素类型返回该元素占用字节
print(array.itemsize)
# 输出 4
# 返回总占用字节数
print(array.nbytes)
# 输出 48

# 返回元素类型
print(array.dtype)
# 输出 int32

# 返回一个重新定义 dtype 的矩阵副本。
array2 = np.asanyarray(array, dtype=np.object)
print(array2)
print(array2.dtype)
# 输出 object
# 或者使用 astype
array2 = array.astype(np.float32)
print(array2.dtype)
```

```
# 元素求和
array = np.array([
    [1, 3, 5, 7],
    [2, 4, 6, 8],
    [10, 11, 12, 13]
])
print(np.sum(array))
# 输出 82
# 按维求和，当前 array.ndim 为 2
print(np.sum(array, axis=0))
# 输出 [13 18 23 28]
print(np.sum(array, axis=1))
# 输出 [16 20 46]
print(np.sum(array, axis=-1))
# 输出 [16 20 46]

# 元素求积
print(np.prod(array))
# 输出 691891200

# 最值
print(np.min(array))
# 输出 1
print(np.max(array))
# 输出 13
print(np.min(array, axis=0))
# 输出 [1 3 5 7]
print(np.max(array, axis=1))
# 输出 [ 7  8 13]
# 索引值最值
print(array.argmin())
# 输出 0
print(array.argmin(axis=0))
# 输出 [0 0 0 0]
print(array.argmax(axis=1))
# 输出 [3 3 3]

# 平均值
print(array.mean())
# 输出 6.833333333333333
print(array.mean(axis=1))
# 输出 [ 4.   5.  11.5]

# 标准偏差
print(array.std())
# 输出 3.8477987935383986

# 方差
print(array.var())
# 输出 14.805555555555555

# 数值限制（元素小于2就用2替代，大于6用6替代）
array = array.clip(2, 6)
print(array)
# 输出
"""
[[2 3 5 6]
 [2 4 6 6]
 [6 6 6 6]]
"""
```

```
# 四舍五入（默认保留整数位）
array = np.array([1.57, 2.61, 7.89])
print(array.round())
# 输出 [2. 3. 8.]
# 指定保留到小数点后1位
print(array.round(1))
# 输出 [1.6 2.6 7.9]
```

```
# 排序
array = np.array([
    [1.57, 2.61, 7.89],
    [3.65, 7.98, 1.66],
    [2.22, 6.35, 1.23]
])
array2 = np.sort(array, axis=1)
print(array2)
# 输出
"""
[[1.57 2.61 7.89]
 [1.66 3.65 7.98]
 [1.23 2.22 6.35]]
"""
array2 = np.sort(array, axis=0)
print(array2)
# 输出
"""
[[1.57 2.61 1.23]
 [2.22 6.35 1.66]
 [3.65 7.98 7.89]]
"""
# 返回排序后由索引值组成的矩阵
array2 = np.argsort(array, axis=0)
print(array2)
# 输出
"""
[[0 0 2]
 [2 2 1]
 [1 1 0]]
"""
# 自动按照平均间距构造有序的 10 个数
array2 = np.linspace(0, 10, 10)
print(array2)
# 输出
"""
[ 0.          1.11111111  2.22222222  3.33333333  4.44444444  5.55555556
  6.66666667  7.77777778  8.88888889 10.        ]
"""
value = np.array([2.5, 6.5, 9.5])
# 在有序的矩阵中查找合适的插入位置，返回索引值组成的列表，不影响 array2
array3 = np.searchsorted(array2, value)
print(array3)
# 输出
# [3 6 9]

# 独立行或列排序，返回索引值组成的列表（不是很理解，需要再次测试）
index = np.lexsort([-1 * array[:, 0], array[:, 2]])
print(index)
# 输出 [2 1 0]
```

```
# 矩阵形状操作
# 修改维数
array = np.arange(10)
print(array.shape)
# 输出 (10,)
array.shape = [2, 5]
print(array)
# 输出
"""
[[0 1 2 3 4]
 [5 6 7 8 9]]
"""

# 新增维
array = np.arange(10)
print(array.shape)
# 输出 (10,)
array2 = array[np.newaxis, :]
print(array2.shape)
# 输出 (1, 10)
array2 = array[:, np.newaxis]
print(array2.shape)
# 输出 (10, 1)
# 去除多余的维数
array.squeeze()
print(array.shape)
# 输出 (10,)
# 矩阵转置，不改变原矩阵
array.shape = [2, 5]
print(array)
# 输出
"""
[[0 1 2 3 4]
 [5 6 7 8 9]]
"""
print(array.transpose())
# 或 array.T
"""
[[0 5]
 [1 6]
 [2 7]
 [3 8]
 [4 9]]
"""
# 矩阵拼接
# 需要传入元组
array2 = np.concatenate((array, array))
# 默认 axis=0，也可以使用 np.vstack((array, array))
print(array2)
"""
[[0 1 2 3 4]
 [5 6 7 8 9]
 [0 1 2 3 4]
 [5 6 7 8 9]]
"""
array2 = np.concatenate((array, array), axis=1)
# axis=1 的情况也可以使用 np.hstack((array, array))
print(array2)
"""
[[0 1 2 3 4 0 1 2 3 4]
 [5 6 7 8 9 5 6 7 8 9]]
"""
# 改为一维矩阵，均不改变原矩阵
print(array.flatten())
# 输出 [0 1 2 3 4 5 6 7 8 9]
# 或
print(array.ravel())
# 输出 [0 1 2 3 4 5 6 7 8 9]
```

```
# 矩阵生成
# 起始，结束，步长，类型
array = np.arange(1, 10, 2, dtype=np.float)
print(array)
# 输出 [1. 3. 5. 7. 9.]
# 按照平均间距构造 10 个元素
array = np.linspace(0, 10, 10)
print(array)
# 输出
"""
[ 0.          1.11111111  2.22222222  3.33333333  4.44444444  5.55555556
  6.66666667  7.77777778  8.88888889 10.        ]
"""
# 按照 10 为底数的平均间距构造 5 个元素
array = np.logspace(0, 1, 5)
print(array)
# 输出 [ 1.          1.77827941  3.16227766  5.62341325 10.        ]
# 查看帮助文档
print(help(np.logspace))
# 构造网格
```

## Numpy 的 ndarray 与 matrix 两者的特性
Numpy matrices必须是2维的,但是 numpy arrays (ndarrays) 可以是多维的（1D，2D，3D····ND）. Matrix是Array的一个小的分支，包含于Array。所以matrix 拥有array的所有特性。

在numpy中matrix的主要优势是：相对简单的乘法运算符号。例如，a和b是两个matrices，那么a*b，就是矩阵积。而不用np.dot()。

matrix 和 array 都可以通过objects后面加.T 得到其转置。但是 matrix objects 还可以在后面加 .H f得到共轭矩阵, 加 .I 得到逆矩阵。

相反的是在numpy里面arrays遵从逐个元素的运算，所以对于array：c 和d的c*d运算相当于matlab里面的c.*d运算。

而矩阵相乘，则需要numpy里面的dot命令 :

问题就出来了，如果一个程序里面既有matrix 又有array，会让人脑袋大。但是如果只用array，你不仅可以实现matrix所有的功能，还减少了编程和阅读的麻烦。

当然你可以通过下面的两条命令轻松的实现两者之间的转换：np.asmatrix和np.asarray

对我来说，numpy 中的array与numpy中的matrix，matlab中的matrix的最大的不同是，在做归约运算时，array的维数会发生变化，但matrix总是保持为2维。

matrix是array的分支，matrix和array在很多时候都是通用的，你用哪一个都一样。但这时候，官方建议大家如果两个可以通用，那就选择array，因为array更灵活，速度更快，很多人把二维的array也翻译成矩阵。

但是matrix的优势就是相对简单的运算符号，比如两个矩阵相乘，就是用符号*，但是array相乘不能这么用，得用方法.dot()

array的优势就是不仅仅表示二维，还能表示3、4、5...维，而且在大部分Python程序里，array也是更常用的。

现在我们讨论numpy的多维数组

例如，在3D空间一个点的坐标[1, 2, 3]是一个秩为1的数组，因为它只有一个轴。那个轴长度为3.又例如，在以下例子中，数组的秩为2(它有两个维度).第一个维度长度为2,第二个维度长度为3.

[[ 1., 0., 0.],
 [ 0., 1., 2.]]
NumPy的数组类被称作ndarray。通常被称作数组。注意numpy.array和标准Python库类array.array并不相同，后者只处理一维数组和提供少量功能。更多重要ndarray对象属性有：

ndarray.ndim

数组轴的个数，在python的世界中，轴的个数被称作秩

ndarray.shape

数组的维度。这是一个指示数组在每个维度上大小的整数元组。例如一个n排m列的矩阵，它的shape属性将是(2,3),这个元组的长度显然是秩，即维度或者ndim属性

ndarray.size

数组元素的总个数，等于shape属性中元组元素的乘积。

ndarray.dtype

一个用来描述数组中元素类型的对象，可以通过创造或指定dtype使用标准Python类型。另外NumPy提供它自己的数据类型。

ndarray.itemsize

数组中每个元素的字节大小。例如，一个元素类型为float64的数组itemsiz属性值为8(=64/8),又如，一个元素类型为complex32的数组item属性为4(=32/8).

ndarray.data

包含实际数组元素的缓冲区，通常我们不需要使用这个属性，因为我们总是通过索引来使用数组中的元素。

一个例子1

>>> from numpy import *
>>> a = arange(15).reshape(3, 5)
>>> a
array([[ 0, 1, 2, 3, 4],
 [ 5, 6, 7, 8, 9],
 [10, 11, 12, 13, 14]])
>>> a.shape
(3, 5)
>>> a.ndim
2
>>> a.dtype.name
'int32'
>>> a.itemsize
4
>>> a.size
15
>>> type(a)
numpy.ndarray
>>> b = array([6, 7, 8])
>>> b
array([6, 7, 8])
>>> type(b)
numpy.ndarray
创建数组
有好几种创建数组的方法。

例如，你可以使用array函数从常规的Python列表和元组创造数组。所创建的数组类型由原序列中的元素类型推导而来。

>>> from numpy import *
>>> a = array( [2,3,4] )
>>> a
array([2, 3, 4])
>>> a.dtype
dtype('int32')
>>> b = array([1.2, 3.5, 5.1])
>>> b.dtype
dtype('float64')
一个常见的错误包括用多个数值参数调用array而不是提供一个由数值组成的列表作为一个参数。

>>> a = array(1,2,3,4) # WRONG
>>> a = array([1,2,3,4]) # RIGHT
数组将序列包含序列转化成二维的数组，序列包含序列包含序列转化成三维数组等等。

>>> b = array( [ (1.5,2,3), (4,5,6) ] )
>>> b
array([[ 1.5, 2. , 3. ],
 [ 4. , 5. , 6. ]])
数组类型可以在创建时显示指定

>>> c = array( [ [1,2], [3,4] ], dtype=complex )
>>> c
array([[ 1.+0.j, 2.+0.j],
 [ 3.+0.j, 4.+0.j]])
通常，数组的元素开始都是未知的，但是它的大小已知。因此，NumPy提供了一些使用占位符创建数组的函数。这最小化了扩展数组的需要和高昂的运算代价。

函数function创建一个全是0的数组，函数ones创建一个全1的数组，函数empty创建一个内容随机并且依赖与内存状态的数组。默认创建的数组类型(dtype)都是float64。

>>> zeros( (3,4) )
array([[0., 0., 0., 0.],
 [0., 0., 0., 0.],
 [0., 0., 0., 0.]])
>>> ones( (2,3,4), dtype=int16 )  # dtype can also be specified
array([[[ 1, 1, 1, 1],
 [ 1, 1, 1, 1],
 [ 1, 1, 1, 1]],
 [[ 1, 1, 1, 1],
 [ 1, 1, 1, 1],
 [ 1, 1, 1, 1]]], dtype=int16)
>>> empty( (2,3) )
array([[ 3.73603959e-262, 6.02658058e-154, 6.55490914e-260],
 [ 5.30498948e-313, 3.14673309e-307, 1.00000000e+000]])
为了创建一个数列，NumPy提供一个类似arange的函数返回数组而不是列表:

>>> arange( 10, 30, 5 )
array([10, 15, 20, 25])
>>> arange( 0, 2, 0.3 )   # it accepts float arguments
array([ 0. , 0.3, 0.6, 0.9, 1.2, 1.5, 1.8])
当arange使用浮点数参数时，由于有限的浮点数精度，通常无法预测获得的元素个数。因此，最好使用函数linspace去接收我们想要的元素个数来代替用range来指定步长。

其它函数array, zeros, zeros_like, ones, ones_like, empty, empty_like, arange, linspace, rand, randn, fromfunction, fromfile参考：NumPy示例

打印数组

当你打印一个数组，NumPy以类似嵌套列表的形式显示它，但是呈以下布局：

最后的轴从左到右打印

次后的轴从顶向下打印

剩下的轴从顶向下打印，每个切片通过一个空行与下一个隔开

一维数组被打印成行，二维数组成矩阵，三维数组成矩阵列表。

>>> a = arange(6)    # 1d array
>>> print a
[0 1 2 3 4 5]
>>>
>>> b = arange(12).reshape(4,3)  # 2d array
>>> print b
[[ 0 1 2]
 [ 3 4 5]
 [ 6 7 8]
 [ 9 10 11]]
>>>
>>> c = arange(24).reshape(2,3,4)  # 3d array
>>> print c
[[[ 0 1 2 3]
 [ 4 5 6 7]
 [ 8 9 10 11]]
 [[12 13 14 15]
 [16 17 18 19]
 [20 21 22 23]]]
查看形状操作一节获得有关reshape的更多细节

如果一个数组用来打印太大了，NumPy自动省略中间部分而只打印角落

>>> print arange(10000)
[ 0 1 2 ..., 9997 9998 9999]
>>>
>>> print arange(10000).reshape(100,100)
[[ 0 1 2 ..., 97 98 99]
 [ 100 101 102 ..., 197 198 199]
 [ 200 201 202 ..., 297 298 299]
 ...,
 [9700 9701 9702 ..., 9797 9798 9799]
 [9800 9801 9802 ..., 9897 9898 9899]
 [9900 9901 9902 ..., 9997 9998 9999]]
禁用NumPy的这种行为并强制打印整个数组，你可以设置printoptions参数来更改打印选项。

>>> set_printoptions(threshold='nan')
基本运算

数组的算术运算是按元素的。新的数组被创建并且被结果填充。

>>> a = array( [20,30,40,50] )
>>> b = arange( 4 )
>>> b
array([0, 1, 2, 3])
>>> c = a-b
>>> c
array([20, 29, 38, 47])
>>> b**2
array([0, 1, 4, 9])
>>> 10*sin(a)
array([ 9.12945251, -9.88031624, 7.4511316 , -2.62374854])
>>> a<35
array([True, True, False, False], dtype=bool)
不像许多矩阵语言，NumPy中的乘法运算符*指示按元素计算，矩阵乘法可以使用dot函数或创建矩阵对象实现(参见教程中的矩阵章节)

>>> A = array( [[1,1],
...  [0,1]] )
>>> B = array( [[2,0],
...  [3,4]] )
>>> A*B    # elementwise product
array([[2, 0],
 [0, 4]])
>>> dot(A,B)   # matrix product
array([[5, 4],
 [3, 4]])
有些操作符像+=和*=被用来更改已存在数组而不创建一个新的数组。

>>> a = ones((2,3), dtype=int)
>>> b = random.random((2,3))
>>> a *= 3
>>> a
array([[3, 3, 3],
 [3, 3, 3]])
>>> b += a
>>> b
array([[ 3.69092703, 3.8324276 , 3.0114541 ],
 [ 3.18679111, 3.3039349 , 3.37600289]])
>>> a += b     # b is converted to integer type
>>> a
array([[6, 6, 6],
 [6, 6, 6]])
当运算的是不同类型的数组时，结果数组和更普遍和精确的已知(这种行为叫做upcast)。

>>> a = ones(3, dtype=int32)
>>> b = linspace(0,pi,3)
>>> b.dtype.name
'float64'
>>> c = a+b
>>> c
array([ 1. , 2.57079633, 4.14159265])
>>> c.dtype.name
'float64'
>>> d = exp(c*1j)
>>> d
array([ 0.54030231+0.84147098j, -0.84147098+0.54030231j,
 -0.54030231-0.84147098j])
>>> d.dtype.name
'complex128'
许多非数组运算，如计算数组所有元素之和，被作为ndarray类的方法实现

>>> a = random.random((2,3))
>>> a
array([[ 0.6903007 , 0.39168346, 0.16524769],
 [ 0.48819875, 0.77188505, 0.94792155]])
>>> a.sum()
3.4552372100521485
>>> a.min()
0.16524768654743593
>>> a.max()
0.9479215542670073
这些运算默认应用到数组好像它就是一个数字组成的列表，无关数组的形状。然而，指定axis参数你可以吧运算应用到数组指定的轴上：

>>> b = arange(12).reshape(3,4)
>>> b
array([[ 0, 1, 2, 3],
 [ 4, 5, 6, 7],
 [ 8, 9, 10, 11]])
>>>
>>> b.sum(axis=0)    # sum of each column
array([12, 15, 18, 21])
>>>
>>> b.min(axis=1)    # min of each row
array([0, 4, 8])
>>>
>>> b.cumsum(axis=1)    # cumulative sum along each row
array([[ 0, 1, 3, 6],
 [ 4, 9, 15, 22],
 [ 8, 17, 27, 38]])
通用函数(ufunc)

NumPy提供常见的数学函数如sin,cos和exp。在NumPy中，这些叫作“通用函数”(ufunc)。在NumPy里这些函数作用按数组的元素运算，产生一个数组作为输出。

>>> B = arange(3)
>>> B
array([0, 1, 2])
>>> exp(B)
array([ 1. , 2.71828183, 7.3890561 ])
>>> sqrt(B)
array([ 0. , 1. , 1.41421356])
>>> C = array([2., -1., 4.])
>>> add(B, C)
array([ 2., 0., 6.])
更多函数 all, alltrue, any, apply along axis, argmax, argmin, argsort, average, bincount, ceil, clip, conj, conjugate, corrcoef, cov, cross, cumprod, cumsum, diff, dot, floor, inner, inv, lexsort, max, maximum, mean, median, min, minimum, nonzero, outer, prod, re, round, sometrue, sort, std, sum, trace, transpose, var, vdot, vectorize, where 参见:NumPy示例

索引，切片和迭代

一维数组可以被索引、切片和迭代，就像列表和其它Python序列。

>>> a = arange(10)**3
>>> a
array([ 0, 1, 8, 27, 64, 125, 216, 343, 512, 729])
>>> a[2]
8
>>> a[2:5]
array([ 8, 27, 64])
>>> a[:6:2] = -1000 # equivalent to a[0:6:2] = -1000; from start to position 6, exclusive, set every 2nd element to -1000
>>> a
array([-1000, 1, -1000, 27, -1000, 125, 216, 343, 512, 729])
>>> a[ : :-1]     # reversed a
array([ 729, 512, 343, 216, 125, -1000, 27, -1000, 1, -1000])
>>> for i in a:
...  print i**(1/3.),
...
nan 1.0 nan 3.0 nan 5.0 6.0 7.0 8.0 9.0
多维数组可以每个轴有一个索引。这些索引由一个逗号分割的元组给出。

>>> def f(x,y):
...  return 10*x+y
...
>>> b = fromfunction(f,(5,4),dtype=int)
>>> b
array([[ 0, 1, 2, 3],
 [10, 11, 12, 13],
 [20, 21, 22, 23],
 [30, 31, 32, 33],
 [40, 41, 42, 43]])
>>> b[2,3]
23
>>> b[0:5, 1]   # each row in the second column of b
array([ 1, 11, 21, 31, 41])
>>> b[ : ,1]   # equivalent to the previous example
array([ 1, 11, 21, 31, 41])
>>> b[1:3, : ]   # each column in the second and third row of b
array([[10, 11, 12, 13],
 [20, 21, 22, 23]])
当少于轴数的索引被提供时，确失的索引被认为是整个切片：

>>> b[-1]     # the last row. Equivalent to b[-1,:]
array([40, 41, 42, 43])
b[i]中括号中的表达式被当作i和一系列:，来代表剩下的轴。NumPy也允许你使用“点”像b[i,...]。

点(…)代表许多产生一个完整的索引元组必要的分号。如果x是秩为5的数组(即它有5个轴)，那么:

x[1,2,…] 等同于 x[1,2,:,:,:],
x[…,3] 等同于 x[:,:,:,:,3]
x[4,…,5,:] 等同 x[4,:,:,5,:].
 >>> c = array( [ [[ 0, 1, 2], # a 3D array (two stacked 2D arrays) ... [ 10, 12, 13]], ... ... [[100,101,102], ... [110,112,113]] ] ) >>> c.shape (2, 2, 3) >>> c[1,...] # same as c[1,:,:] or c[1] array([[100, 101, 102], [110, 112, 113]]) >>> c[...,2] # same as c[:,:,2] array([[ 2, 13], [102, 113]])
迭代多维数组是就第一个轴而言的:2

>>> for row in b:
...  print row
...
[0 1 2 3]
[10 11 12 13]
[20 21 22 23]
[30 31 32 33]
[40 41 42 43]
然而，如果一个人想对每个数组中元素进行运算，我们可以使用flat属性，该属性是数组元素的一个迭代器:

>>> for element in b.flat:
...  print element,
...
0 1 2 3 10 11 12 13 20 21 22 23 30 31 32 33 40 41 42 43
更多[], …, newaxis, ndenumerate, indices, index exp 参考NumPy示例

形状操作

更改数组的形状

一个数组的形状由它每个轴上的元素个数给出：

>>> a = floor(10*random.random((3,4)))
>>> a
array([[ 7., 5., 9., 3.],
 [ 7., 2., 7., 8.],
 [ 6., 8., 3., 2.]])
>>> a.shape
(3, 4)
一个数组的形状可以被多种命令修改：

>>> a.ravel() # flatten the array
array([ 7., 5., 9., 3., 7., 2., 7., 8., 6., 8., 3., 2.])
>>> a.shape = (6, 2)
>>> a.transpose()
array([[ 7., 9., 7., 7., 6., 3.],
 [ 5., 3., 2., 8., 8., 2.]])
由ravel()展平的数组元素的顺序通常是“C风格”的，就是说，最右边的索引变化得最快，所以元素a[0,0]之后是a[0,1]。如果数组被改变形状(reshape)成其它形状，数组仍然是“C风格”的。NumPy通常创建一个以这个顺序保存数据的数组，所以ravel()将总是不需要复制它的参数3。但是如果数组是通过切片其它数组或有不同寻常的选项时，它可能需要被复制。函数reshape()和ravel()还可以被同过一些可选参数构建成FORTRAN风格的数组，即最左边的索引变化最快。

reshape函数改变参数形状并返回它，而resize函数改变数组自身。

>>> a
array([[ 7., 5.],
 [ 9., 3.],
 [ 7., 2.],
 [ 7., 8.],
 [ 6., 8.],
 [ 3., 2.]])
>>> a.resize((2,6))
>>> a
array([[ 7., 5., 9., 3., 7., 2.],
 [ 7., 8., 6., 8., 3., 2.]])
如果在改变形状操作中一个维度被给做-1，其维度将自动被计算

更多 shape, reshape, resize, ravel 参考NumPy示例

组合(stack)不同的数组

几种方法可以沿不同轴将数组堆叠在一起：

>>> a = floor(10*random.random((2,2)))
>>> a
array([[ 1., 1.],
 [ 5., 8.]])
>>> b = floor(10*random.random((2,2)))
>>> b
array([[ 3., 3.],
 [ 6., 0.]])
>>> vstack((a,b))
array([[ 1., 1.],
 [ 5., 8.],
 [ 3., 3.],
 [ 6., 0.]])
>>> hstack((a,b))
array([[ 1., 1., 3., 3.],
 [ 5., 8., 6., 0.]])
函数column_stack以列将一维数组合成二维数组，它等同与vstack对一维数组。

>>> column_stack((a,b)) # With 2D arrays
array([[ 1., 1., 3., 3.],
 [ 5., 8., 6., 0.]])
>>> a=array([4.,2.])
>>> b=array([2.,8.])
>>> a[:,newaxis] # This allows to have a 2D columns vector
array([[ 4.],
 [ 2.]])
>>> column_stack((a[:,newaxis],b[:,newaxis]))
array([[ 4., 2.],
 [ 2., 8.]])
>>> vstack((a[:,newaxis],b[:,newaxis])) # The behavior of vstack is different
array([[ 4.],
 [ 2.],
 [ 2.],
 [ 8.]])
row_stack函数，另一方面，将一维数组以行组合成二维数组。

对那些维度比二维更高的数组，hstack沿着第二个轴组合，vstack沿着第一个轴组合,concatenate允许可选参数给出组合时沿着的轴。

Note

在复杂情况下，r_[]和c_[]对创建沿着一个方向组合的数很有用，它们允许范围符号(“:”):

>>> r_[1:4,0,4]
array([1, 2, 3, 0, 4])
当使用数组作为参数时，r_和c_的默认行为和vstack和hstack很像，但是允许可选的参数给出组合所沿着的轴的代号。

更多函数hstack , vstack, column_stack , row_stack , concatenate , c_ , r_ 参见NumPy示例.

将一个数组分割(split)成几个小数组

使用hsplit你能将数组沿着它的水平轴分割，或者指定返回相同形状数组的个数，或者指定在哪些列后发生分割:

>>> a = floor(10*random.random((2,12)))
>>> a
array([[ 8., 8., 3., 9., 0., 4., 3., 0., 0., 6., 4., 4.],
 [ 0., 3., 2., 9., 6., 0., 4., 5., 7., 5., 1., 4.]])
>>> hsplit(a,3) # Split a into 3
[array([[ 8., 8., 3., 9.],
 [ 0., 3., 2., 9.]]), array([[ 0., 4., 3., 0.],
 [ 6., 0., 4., 5.]]), array([[ 0., 6., 4., 4.],
 [ 7., 5., 1., 4.]])]
>>> hsplit(a,(3,4)) # Split a after the third and the fourth column
[array([[ 8., 8., 3.],
 [ 0., 3., 2.]]), array([[ 9.],
 [ 9.]]), array([[ 0., 4., 3., 0., 0., 6., 4., 4.],
 [ 6., 0., 4., 5., 7., 5., 1., 4.]])]
vsplit沿着纵向的轴分割，array split允许指定沿哪个轴分割。

复制和视图

当运算和处理数组时，它们的数据有时被拷贝到新的数组有时不是。这通常是新手的困惑之源。这有三种情况:

完全不拷贝

简单的赋值不拷贝数组对象或它们的数据。

>>> a = arange(12)
>>> b = a  # no new object is created
>>> b is a  # a and b are two names for the same ndarray object
True
>>> b.shape = 3,4 # changes the shape of a
>>> a.shape
(3, 4)
Python 传递不定对象作为参考4，所以函数调用不拷贝数组。

>>> def f(x):
... print id(x)
...
>>> id(a)    # id is a unique identifier of an object
148293216
>>> f(a)
148293216
视图(view)和浅复制

不同的数组对象分享同一个数据。视图方法创造一个新的数组对象指向同一数据。

>>> c = a.view()
>>> c is a
False
>>> c.base is a   # c is a view of the data owned by a
True
>>> c.flags.owndata
False
>>>
>>> c.shape = 2,6   # a's shape doesn't change
>>> a.shape
(3, 4)
>>> c[0,4] = 1234   # a's data changes
>>> a
array([[ 0, 1, 2, 3],
 [1234, 5, 6, 7],
 [ 8, 9, 10, 11]])
切片数组返回它的一个视图：

>>> s = a[ : , 1:3] # spaces added for clarity; could also be written "s = a[:,1:3]"
>>> s[:] = 10  # s[:] is a view of s. Note the difference between s=10 and s[:]=10
>>> a
array([[ 0, 10, 10, 3],
 [1234, 10, 10, 7],
 [ 8, 10, 10, 11]])
深复制

这个复制方法完全复制数组和它的数据。

>>> d = a.copy()    # a new array object with new data is created
>>> d is a
False
>>> d.base is a    # d doesn't share anything with a
False
>>> d[0,0] = 9999
>>> a
array([[ 0, 10, 10, 3],
 [1234, 10, 10, 7],
 [ 8, 10, 10, 11]])
函数和方法(method)总览

这是个NumPy函数和方法分类排列目录。这些名字链接到NumPy示例,你可以看到这些函数起作用。5

创建数组

arange, array, copy, empty, empty_like, eye, fromfile, fromfunction, identity, linspace, logspace, mgrid, ogrid, ones, ones_like, r , zeros, zeros_like
转化

astype, atleast 1d, atleast 2d, atleast 3d, mat
操作

array split, column stack, concatenate, diagonal, dsplit, dstack, hsplit, hstack, item, newaxis, ravel, repeat, reshape, resize, squeeze, swapaxes, take, transpose, vsplit, vstack
询问

all, any, nonzero, where
排序

argmax, argmin, argsort, max, min, ptp, searchsorted, sort
运算

choose, compress, cumprod, cumsum, inner, fill, imag, prod, put, putmask, real, sum
基本统计

cov, mean, std, var
基本线性代数

cross, dot, outer, svd, vdot
进阶

广播法则(rule)

广播法则能使通用函数有意义地处理不具有相同形状的输入。

广播第一法则是，如果所有的输入数组维度不都相同，一个“1”将被重复地添加在维度较小的数组上直至所有的数组拥有一样的维度。

广播第二法则确定长度为1的数组沿着特殊的方向表现地好像它有沿着那个方向最大形状的大小。对数组来说，沿着那个维度的数组元素的值理应相同。

应用广播法则之后，所有数组的大小必须匹配。更多细节可以从这个文档找到。

花哨的索引和索引技巧

NumPy比普通Python序列提供更多的索引功能。除了索引整数和切片，正如我们之前看到的，数组可以被整数数组和布尔数组索引。

通过数组索引

>>> a = arange(12)**2    # the first 12 square numbers
>>> i = array( [ 1,1,3,8,5 ] )   # an array of indices
>>> a[i]     # the elements of a at the positions i
array([ 1, 1, 9, 64, 25])
>>>
>>> j = array( [ [ 3, 4], [ 9, 7 ] ] )  # a bidimensional array of indices
>>> a[j]     # the same shape as j
array([[ 9, 16],
 [81, 49]])
当被索引数组a是多维的时，每一个唯一的索引数列指向a的第一维[^5]。以下示例通过将图片标签用调色版转换成色彩图像展示了这种行为。

>>> palette = array( [ [0,0,0],  # black
...   [255,0,0],  # red
...   [0,255,0],  # green
...   [0,0,255],  # blue
...   [255,255,255] ] ) # white
>>> image = array( [ [ 0, 1, 2, 0 ],  # each value corresponds to a color in the palette
...   [ 0, 3, 4, 0 ] ] )
>>> palette[image]    # the (2,4,3) color image
array([[[ 0, 0, 0],
 [255, 0, 0],
 [ 0, 255, 0],
 [ 0, 0, 0]],
 [[ 0, 0, 0],
 [ 0, 0, 255],
 [255, 255, 255],
 [ 0, 0, 0]]])
我们也可以给出不不止一维的索引，每一维的索引数组必须有相同的形状。

>>> a = arange(12).reshape(3,4)
>>> a
array([[ 0, 1, 2, 3],
 [ 4, 5, 6, 7],
 [ 8, 9, 10, 11]])
>>> i = array( [ [0,1],   # indices for the first dim of a
...  [1,2] ] )
>>> j = array( [ [2,1],   # indices for the second dim
...  [3,3] ] )
>>>
>>> a[i,j]     # i and j must have equal shape
array([[ 2, 5],
 [ 7, 11]])
>>>
>>> a[i,2]
array([[ 2, 6],
 [ 6, 10]])
>>>
>>> a[:,j]     # i.e., a[ : , j]
array([[[ 2, 1],
 [ 3, 3]],
 [[ 6, 5],
 [ 7, 7]],
 [[10, 9],
 [11, 11]]])
自然，我们可以把i和j放到序列中(比如说列表)然后通过list索引。

>>> l = [i,j]
>>> a[l]     # equivalent to a[i,j]
array([[ 2, 5],
 [ 7, 11]])
然而，我们不能把i和j放在一个数组中，因为这个数组将被解释成索引a的第一维。

>>> s = array( [i,j] )
>>> a[s]     # not what we want
---------------------------------------------------------------------------
IndexError    Traceback (most recent call last)
 in ()
----> 1 a[s]
IndexError: index (3) out of range (0<=index<2) in dimension 0
>>>
>>> a[tuple(s)]    # same as a[i,j]
array([[ 2, 5],
 [ 7, 11]])
另一个常用的数组索引用法是搜索时间序列最大值6。

>>> time = linspace(20, 145, 5)   # time scale
>>> data = sin(arange(20)).reshape(5,4)  # 4 time-dependent series
>>> time
array([ 20. , 51.25, 82.5 , 113.75, 145. ])
>>> data
array([[ 0. , 0.84147098, 0.90929743, 0.14112001],
 [-0.7568025 , -0.95892427, -0.2794155 , 0.6569866 ],
 [ 0.98935825, 0.41211849, -0.54402111, -0.99999021],
 [-0.53657292, 0.42016704, 0.99060736, 0.65028784],
 [-0.28790332, -0.96139749, -0.75098725, 0.14987721]])
>>>
>>> ind = data.argmax(axis=0)   # index of the maxima for each series
>>> ind
array([2, 0, 3, 1])
>>>
>>> time_max = time[ ind]   # times corresponding to the maxima
>>>
>>> data_max = data[ind, xrange(data.shape[1])] # => data[ind[0],0], data[ind[1],1]...
>>>
>>> time_max
array([ 82.5 , 20. , 113.75, 51.25])
>>> data_max
array([ 0.98935825, 0.84147098, 0.99060736, 0.6569866 ])
>>>
>>> all(data_max == data.max(axis=0))
True
你也可以使用数组索引作为目标来赋值：

>>> a = arange(5)
>>> a
array([0, 1, 2, 3, 4])
>>> a[[1,3,4]] = 0
>>> a
array([0, 0, 2, 0, 0])
然而，当一个索引列表包含重复时，赋值被多次完成，保留最后的值：

>>> a = arange(5)
>>> a[[0,0,2]]=[1,2,3]
>>> a
array([2, 1, 3, 3, 4])
这足够合理，但是小心如果你想用Python的+=结构，可能结果并非你所期望：

>>> a = arange(5)
>>> a[[0,0,2]]+=1
>>> a
array([1, 1, 3, 3, 4])
即使0在索引列表中出现两次，索引为0的元素仅仅增加一次。这是因为Python要求a+=1和a=a+1等同。

通过布尔数组索引

当我们使用整数数组索引数组时，我们提供一个索引列表去选择。通过布尔数组索引的方法是不同的我们显式地选择数组中我们想要和不想要的元素。

我们能想到的使用布尔数组的索引最自然方式就是使用和原数组一样形状的布尔数组。

>>> a = arange(12).reshape(3,4)
>>> b = a > 4
>>> b      # b is a boolean with a's shape
array([[False, False, False, False],
 [False, True, True, True],
 [True, True, True, True]], dtype=bool)
>>> a[b]     # 1d array with the selected elements
array([ 5, 6, 7, 8, 9, 10, 11])
这个属性在赋值时非常有用：

>>> a[b] = 0     # All elements of 'a' higher than 4 become 0
>>> a
array([[0, 1, 2, 3],
 [4, 0, 0, 0],
 [0, 0, 0, 0]])
你可以参考曼德博集合示例看看如何使用布尔索引来生成曼德博集合的图像。

第二种通过布尔来索引的方法更近似于整数索引；对数组的每个维度我们给一个一维布尔数组来选择我们想要的切片。

>>> a = arange(12).reshape(3,4)
>>> b1 = array([False,True,True])  # first dim selection
>>> b2 = array([True,False,True,False]) # second dim selection
>>>
>>> a[b1,:]     # selecting rows
array([[ 4, 5, 6, 7],
 [ 8, 9, 10, 11]])
>>>
>>> a[b1]     # same thing
array([[ 4, 5, 6, 7],
 [ 8, 9, 10, 11]])
>>>
>>> a[:,b2]     # selecting columns
array([[ 0, 2],
 [ 4, 6],
 [ 8, 10]])
>>>
>>> a[b1,b2]     # a weird thing to do
array([ 4, 10])
注意一维数组的长度必须和你想要切片的维度或轴的长度一致，在之前的例子中，b1是一个秩为1长度为三的数组(a的行数)，b2(长度为4)与a的第二秩(列)相一致。7

ix_()函数

ix_函数可以为了获得多元组的结果而用来结合不同向量。例如，如果你想要用所有向量a、b和c元素组成的三元组来计算a+b*c：

>>> a = array([2,3,4,5])
>>> b = array([8,5,4])
>>> c = array([5,4,6,8,3])
>>> ax,bx,cx = ix_(a,b,c)
>>> ax
array([[[2]],
 [[3]],
 [[4]],
 [[5]]])
>>> bx
array([[[8],
 [5],
 [4]]])
>>> cx
array([[[5, 4, 6, 8, 3]]])
>>> ax.shape, bx.shape, cx.shape
((4, 1, 1), (1, 3, 1), (1, 1, 5))
>>> result = ax+bx*cx
>>> result
array([[[42, 34, 50, 66, 26],
 [27, 22, 32, 42, 17],
 [22, 18, 26, 34, 14]],
 [[43, 35, 51, 67, 27],
 [28, 23, 33, 43, 18],
 [23, 19, 27, 35, 15]],
 [[44, 36, 52, 68, 28],
 [29, 24, 34, 44, 19],
 [24, 20, 28, 36, 16]],
 [[45, 37, 53, 69, 29],
 [30, 25, 35, 45, 20],
 [25, 21, 29, 37, 17]]])
>>> result[3,2,4]
17
>>> a[3]+b[2]*c[4]
17
你也可以实行如下简化：

def ufunc_reduce(ufct, *vectors):
 vs = ix_(*vectors)
 r = ufct.identity
 for v in vs:
 r = ufct(r,v)
 return r
然后这样使用它：

>>> ufunc_reduce(add,a,b,c)
array([[[15, 14, 16, 18, 13],
 [12, 11, 13, 15, 10],
 [11, 10, 12, 14, 9]],
 [[16, 15, 17, 19, 14],
 [13, 12, 14, 16, 11],
 [12, 11, 13, 15, 10]],
 [[17, 16, 18, 20, 15],
 [14, 13, 15, 17, 12],
 [13, 12, 14, 16, 11]],
 [[18, 17, 19, 21, 16],
 [15, 14, 16, 18, 13],
 [14, 13, 15, 17, 12]]])

这个reduce与ufunc.reduce(比如说add.reduce)相比的优势在于它利用了广播法则，避免了创建一个输出大小乘以向量个数的参数数组。8

用字符串索引

参见RecordArray。

线性代数

继续前进，基本线性代数包含在这里。

简单数组运算

参考numpy文件夹中的linalg.py获得更多信息

>>> from numpy import *
>>> from numpy.linalg import *
>>> a = array([[1.0, 2.0], [3.0, 4.0]])
>>> print a
[[ 1. 2.]
 [ 3. 4.]]
>>> a.transpose()
array([[ 1., 3.],
 [ 2., 4.]])
>>> inv(a)
array([[-2. , 1. ],
 [ 1.5, -0.5]])
>>> u = eye(2) # unit 2x2 matrix; "eye" represents "I"
>>> u
array([[ 1., 0.],
 [ 0., 1.]])
>>> j = array([[0.0, -1.0], [1.0, 0.0]])
>>> dot (j, j) # matrix product
array([[-1., 0.],
 [ 0., -1.]])
>>> trace(u) # trace
 2.0
>>> y = array([[5.], [7.]])
>>> solve(a, y)
array([[-3.],
 [ 4.]])
>>> eig(j)
(array([ 0.+1.j, 0.-1.j]),
array([[ 0.70710678+0.j, 0.70710678+0.j],
 [ 0.00000000-0.70710678j, 0.00000000+0.70710678j]]))
Parameters:
 square matrix
Returns
 The eigenvalues, each repeated according to its multiplicity.
 The normalized (unit "length") eigenvectors, such that the
 column ``v[:,i]`` is the eigenvector corresponding to the
 eigenvalue ``w[i]`` .
矩阵类

这是一个关于矩阵类的简短介绍。

>>> A = matrix('1.0 2.0; 3.0 4.0')
>>> A
[[ 1. 2.]
 [ 3. 4.]]
>>> type(A) # file where class is defined
>>> A.T # transpose
[[ 1. 3.]
 [ 2. 4.]]
>>> X = matrix('5.0 7.0')
>>> Y = X.T
>>> Y
[[5.]
 [7.]]
>>> print A*Y # matrix multiplication
[[19.]
 [43.]]
>>> print A.I # inverse
[[-2. 1. ]
 [ 1.5 -0.5]]
>>> solve(A, Y) # solving linear equation
matrix([[-3.],
 [ 4.]])
索引：比较矩阵和二维数组

注意NumPy中数组和矩阵有些重要的区别。NumPy提供了两个基本的对象：一个N维数组对象和一个通用函数对象。其它对象都是建构在它们之上的。特别的，矩阵是继承自NumPy数组对象的二维数组对象。对数组和矩阵，索引都必须包含合适的一个或多个这些组合：整数标量、省略号(ellipses)、整数列表;布尔值，整数或布尔值构成的元组，和一个一维整数或布尔值数组。矩阵可以被用作矩阵的索引，但是通常需要数组、列表或者其它形式来完成这个任务。

像平常在Python中一样，索引是从0开始的。传统上我们用矩形的行和列表示一个二维数组或矩阵，其中沿着0轴的方向被穿过的称作行，沿着1轴的方向被穿过的是列。9

让我们创建数组和矩阵用来切片：

>>> A = arange(12)
>>> A
array([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
>>> A.shape = (3,4)
>>> M = mat(A.copy())
>>> print type(A)," ",type(M)

>>> print A
[[ 0 1 2 3]
 [ 4 5 6 7]
 [ 8 9 10 11]]
>>> print M
[[ 0 1 2 3]
 [ 4 5 6 7]
 [ 8 9 10 11]]
现在，让我们简单的切几片。基本的切片使用切片对象或整数。例如，A[:]和M[:]的求值将表现得和Python索引很相似。然而要注意很重要的一点就是NumPy切片数组不创建数据的副本;切片提供统一数据的视图。

>>> print A[:]; print A[:].shape
[[ 0 1 2 3]
 [ 4 5 6 7]
 [ 8 9 10 11]]
(3, 4)
>>> print M[:]; print M[:].shape
[[ 0 1 2 3]
 [ 4 5 6 7]
 [ 8 9 10 11]]
(3, 4)
现在有些和Python索引不同的了：你可以同时使用逗号分割索引来沿着多个轴索引。

>>> print A[:,1]; print A[:,1].shape
[1 5 9]
(3,)
>>> print M[:,1]; print M[:,1].shape
[[1]
 [5]
 [9]]
(3, 1)
注意最后两个结果的不同。对二维数组使用一个冒号产生一个一维数组，然而矩阵产生了一个二维矩阵。10例如，一个M[2,:]切片产生了一个形状为(1,4)的矩阵，相比之下，一个数组的切片总是产生一个最低可能维度11的数组。例如，如果C是一个三维数组，C[...,1]产生一个二维的数组而C[1,:,1]产生一个一维数组。从这时开始，如果相应的矩阵切片结果是相同的话，我们将只展示数组切片的结果。

假如我们想要一个数组的第一列和第三列，一种方法是使用列表切片：

>>> A[:,[1,3]]
array([[ 1, 3],
 [ 5, 7],
 [ 9, 11]])
稍微复杂点的方法是使用take()方法(method):

>>> A[:,].take([1,3],axis=1)
array([[ 1, 3],
 [ 5, 7],
 [ 9, 11]])
如果我们想跳过第一行，我们可以这样：

>>> A[1:,].take([1,3],axis=1)
array([[ 5, 7],
 [ 9, 11]])
或者我们仅仅使用A[1:,[1,3]]。还有一种方法是通过矩阵向量积(叉积)。

>>> A[ix_((1,2),(1,3))]
array([[ 5, 7],
 [ 9, 11]])
为了读者的方便，在次写下之前的矩阵：

>>> A[ix_((1,2),(1,3))]
array([[ 5, 7],
 [ 9, 11]])
现在让我们做些更复杂的。比如说我们想要保留第一行大于1的列。一种方法是创建布尔索引：

>>> A[0,:]>1
array([False, False, True, True], dtype=bool)
>>> A[:,A[0,:]>1]
array([[ 2, 3],
 [ 6, 7],
 [10, 11]])
就是我们想要的！但是索引矩阵没这么方便。

>>> M[0,:]>1
matrix([[False, False, True, True]], dtype=bool)
>>> M[:,M[0,:]>1]
matrix([[2, 3]])
这个过程的问题是用“矩阵切片”来切片产生一个矩阵12，但是矩阵有个方便的A属性，它的值是数组呈现的。所以我们仅仅做以下替代：

>>> M[:,M.A[0,:]>1]
matrix([[ 2, 3],
 [ 6, 7],
 [10, 11]])
如果我们想要在矩阵两个方向有条件地切片，我们必须稍微调整策略，代之以：

>>> A[A[:,0]>2,A[0,:]>1]
array([ 6, 11])
>>> M[M.A[:,0]>2,M.A[0,:]>1]
matrix([[ 6, 11]])
我们需要使用向量积ix_:

>>> A[ix_(A[:,0]>2,A[0,:]>1)]
array([[ 6, 7],
 [10, 11]])
>>> M[ix_(M.A[:,0]>2,M.A[0,:]>1)]
matrix([[ 6, 7],
 [10, 11]])
技巧和提示

下面我们给出简短和有用的提示。

“自动”改变形状

更改数组的维度，你可以省略一个尺寸，它将被自动推导出来。

>>> a = arange(30)
>>> a.shape = 2,-1,3 # -1 means "whatever is needed"
>>> a.shape
(2, 5, 3)
>>> a
array([[[ 0, 1, 2],
 [ 3, 4, 5],
 [ 6, 7, 8],
 [ 9, 10, 11],
 [12, 13, 14]],
 [[15, 16, 17],
 [18, 19, 20],
 [21, 22, 23],
 [24, 25, 26],
 [27, 28, 29]]])
向量组合(stacking)

我们如何用两个相同尺寸的行向量列表构建一个二维数组？在MATLAB中这非常简单：如果x和y是两个相同长度的向量，你仅仅需要做m=[x;y]。在NumPy中这个过程通过函数column_stack、dstack、hstack和vstack来完成，取决于你想要在那个维度上组合。例如：

x = arange(0,10,2)   # x=([0,2,4,6,8])
y = arange(5)    # y=([0,1,2,3,4])
m = vstack([x,y])   # m=([[0,2,4,6,8],
     # [0,1,2,3,4]])
xy = hstack([x,y])   # xy =([0,2,4,6,8,0,1,2,3,4])
二维以上这些函数背后的逻辑会很奇怪。

参考写个Matlab用户的NumPy指南并且在这里添加你的新发现: )

直方图(histogram)

NumPy中histogram函数应用到一个数组返回一对变量：直方图数组和箱式向量。注意：matplotlib也有一个用来建立直方图的函数(叫作hist,正如matlab中一样)与NumPy中的不同。主要的差别是pylab.hist自动绘制直方图，而numpy.histogram仅仅产生数据。

import numpy
import pylab
# Build a vector of 10000 normal deviates with variance 0.5^2 and mean 2
mu, sigma = 2, 0.5
v = numpy.random.normal(mu,sigma,10000)
# Plot a normalized histogram with 50 bins
pylab.hist(v, bins=50, normed=1) # matplotlib version (plot)
pylab.show()
# Compute the histogram with numpy and then plot it
(n, bins) = numpy.histogram(v, bins=50, normed=True) # NumPy version (no plot)
pylab.plot(.5*(bins[1:]+bins[:-1]), n)
pylab.show()
以上这篇基于Python Numpy的数组array和矩阵matrix详解就是小编分享给大家的全部内容了，希望能给大家一个参考，也希望大家多多支持脚本之家。
