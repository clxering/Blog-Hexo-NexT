---
title: 安装 Twisted 出现 not a supported wheel on this platform 错误的解决方案
date: 2019-05-11 16:02:46
categories:
- 后端技术
tags:
- python
---

> 摘要：记录安装 Twisted 出现 not a supported wheel on this platform 错误的解决方案。

<!-- more -->

## 问题描述
安装 Twisted-19.2.0-cp37-cp37m-win_amd64.whl 时提示如下错误：
```
ERROR: Twisted-19.2.0-cp37-cp37m-win_amd64.whl is not a supported wheel on this platform.
```

## 解决方式
通过 pip 检查工具检查接受安装的标签。打开命令行输入下列内容：

```
C:\Users>python
Python 3.7.3 (v3.7.3:ef4ec6ed12, Mar 25 2019, 21:26:53) [MSC v.1916 32 bit (Intel)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import pip._internal
>>> print(pip._internal.pep425tags.get_supported())
[('cp37', 'cp37m', 'win32'), ('cp37', 'none', 'win32'), ('py3', 'none', 'win32'), ('cp37', 'none', 'any'), ('cp3', 'none', 'any'), ('py37', 'none', 'any'), ('py3', 'none', 'any'), ('py36', 'none', 'any'), ('py35', 'none', 'any'), ('py34', 'none', 'any'), ('py33', 'none', 'any'), ('py32', 'none', 'any'), ('py31', 'none', 'any'), ('py30', 'none', 'any')]
>>>
```

**附加内容：如果是 32 位系统，更改如下：**
```
import pip
print(pip.pep425tags.get_supported())
```

根据显示结果，从 https://www.lfd.uci.edu/~gohlke/pythonlibs/#twisted 重新下载：Twisted-19.2.0-cp37-cp37m-win32.whl，安装成功：
```
$ pip install D:/MyDesk/Twisted-19.2.0-cp37-cp37m-win32.whl
Processing d:\twisted-19.2.0-cp37-cp37m-win32.whl
Requirement already satisfied: zope.interface>=4.4.2 in d:\GraphicCalculation\env\lib\site-packages (from Twisted==19.2.0) (4.6.0)
Requirement already satisfied: incremental>=16.10.1 in d:\GraphicCalculation\env\lib\site-packages (from Twisted==19.2.0) (17.5.0)
Requirement already satisfied: Automat>=0.3.0 in d:\GraphicCalculation\env\lib\site-packages (from Twisted==19.2.0) (0.7.0)
Requirement already satisfied: hyperlink>=17.1.1 in d:\GraphicCalculation\env\lib\site-packages (from Twisted==19.2.0) (19.0.0)
Requirement already satisfied: attrs>=17.4.0 in d:\GraphicCalculation\env\lib\site-packages (from Twisted==19.2.0) (19.1.0)
Requirement already satisfied: PyHamcrest>=1.9.0 in d:\GraphicCalculation\env\lib\site-packages (from Twisted==19.2.0) (1.9.0)
Requirement already satisfied: constantly>=15.1 in d:\GraphicCalculation\env\lib\site-packages (from Twisted==19.2.0) (15.1.0)
Requirement already satisfied: setuptools in d:\GraphicCalculation\env\lib\site-packages (from zope.interface>=4.4.2->Twisted==19.2.0) (41.0.1)
Requirement already satisfied: six in d:\GraphicCalculation\env\lib\site-packages (from Automat>=0.3.0->Twisted==19.2.0) (1.12.0)
Requirement already satisfied: idna>=2.5 in d:\GraphicCalculation\env\lib\site-packages (from hyperlink>=17.1.1->Twisted==19.2.0) (2.8)
Installing collected packages: Twisted
Successfully installed Twisted-19.2.0
```
