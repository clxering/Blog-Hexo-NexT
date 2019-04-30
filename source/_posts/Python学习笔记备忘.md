---
title: Python 学习笔记备忘
date: 2019-04-26 17:24:49
categories:
tags:
---

> 摘要：记录 Python 的学习笔记，是阅读《Python编程：从入门到实践》、《Python编程快速上手  让繁琐工作自动化》、《Python学习手册(第4版)》以及《Python高级编程-第2版》之后，经过有机整合而成。

<!-- more -->

## 第一个示例程序

```
print("Hello Python world!")
```

## 变量名应使用小写

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

- 使用 `sort()` 对列表按字母顺序进行永久性排序。

```
cars = ['bmw', 'audi', 'toyota', 'subaru']
cars.sort()
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
