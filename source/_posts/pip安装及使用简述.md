---
title: pip 安装及使用简述
date: 2019-04-30 20:29:49
categories:
- 后端技术
tags:
- python
---

> 摘要：

<!-- more -->


## pip 下载（Linux 为例）
```
# wget "https://pypi.python.org/packages/source/p/pip/pip-1.5.4.tar.gz#md5=834b2904f92d46aaa333267fb1c922bb" --no-check-certificate
```

## pip 安装
```
# tar -xzvf pip-19.0.3.tar.gz
# cd pip-19.0.3
# python setup.py install
```

## pip 安装其他包
```
$ pip install pygal
Collecting pygal
  Downloading https://files.pythonhosted.org/packages/5f/b7/201c9254ac0d2b8ffa3bb2d528d23a4130876d9ba90bc28e99633f323f17/pygal-2.4.0-py2.py3-none-any.whl (127kB)
Installing collected packages: pygal
Successfully installed pygal-2.4.0
```

## pip 查看已安装的包
```
$ pip list
Package         Version
--------------- -------
cycler          0.10.0
kiwisolver      1.1.0
matplotlib      3.0.3
numpy           1.16.3
pip             19.1
pygal           2.4.0
pyparsing       2.4.0
python-dateutil 2.8.0
setuptools      40.8.0
six             1.12.0
```

## pip 检查哪些包需要更新
```
$ pip list --outdated
Package    Version Latest Type
---------- ------- ------ -----
pip        19.0.3  19.1   wheel
setuptools 40.8.0  41.0.1 wheel
You are using pip version 19.0.3, however version 19.1 is available.
You should consider upgrading via the 'python -m pip install --upgrade pip' command.
```

## pip 升级包
```
$ python -m pip install --upgrade pip
Collecting pip
  Downloading https://files.pythonhosted.org/packages/f9/fb/863012b13912709c13cf5cfdbfb304fa6c727659d6290438e1a88df9d848/pip-19.1-py2.py3-none-any.whl (1.4MB)
Installing collected packages: pip
  Found existing installation: pip 19.0.3
    Uninstalling pip-19.0.3:
      Successfully uninstalled pip-19.0.3
Successfully installed pip-19.1

```

2.5 pip卸载包
```
$ pip uninstall SomePackage
  Uninstalling SomePackage:
    /my/env/lib/pythonx.x/site-packages/somepackage
  Proceed (y/n)? y
  Successfully uninstalled SomePackage
```
