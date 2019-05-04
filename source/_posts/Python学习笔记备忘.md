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

## 第一个示例程序

```
print("Hello Python world!")
```

## 变量名应使用小写
（例子，略）

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

- 使用 `sorted()` 对列表进行临时排序，保留列表元素原来的排列顺序，也可向 `sorted()` 传递参数 `reverse=True`。

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
