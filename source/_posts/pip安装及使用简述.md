---
title: pip 安装及使用
date: 2019-04-30 20:29:49
categories:
- 后端技术
tags:
- python
---

> 摘要：记录 pip 安装及使用

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
```
使用国内的镜像源
```
pip install scikit-image -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com
```

## pip 查看已安装的包
```
$ pip list
```

## pip 检查哪些包需要更新
```
$ pip list --outdated
```

## pip 升级包
```
$ python -m pip install --upgrade SomePackage
```

## pip 卸载包
```
$ pip uninstall SomePackage
```
