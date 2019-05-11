---
title: virtualenv 的安装和使用
date: 2019-05-11 11:56:25
categories:
- 后端技术
tags:
- python
---

> 摘要：记录了 virtualenv 的安装和使用流程。

<!-- more -->

## 环境
- python 3.7
- virtualenv 16.5.0

## 安装
执行命令：
```
pip install virtualenv
```

运行完成后，运行 `virtualenv --version`，出现版本号说明成功。可以使用 `virtualenv -h` 命令来查看帮助文档。

## 创建虚拟环境
在项目目录下使用命令：virtualenv env，若虚拟环境创建成功，在当前项目目录下新建一个 env 文件夹。从现在起，任何使用 pip 安装的包将会放在 env 文件夹中

**附加内容：在 virtualenv 1.7 及之后 `--no-site-packages` 参数已经废弃，新建虚拟环境时默认建立一个不带任何第三方包的运行环境。**

**附加内容：在创建虚拟环境时可以选择指定的 Python 解释器，默认使用环境变量设置的解释器。**
```
$ virtualenv -p /usr/local/bin/python3 env
```

## 激活环境
### windows
进入 Scripts 目录（`cd env\Scripts`）执行 `activate` 命令，成功后命令行开头会出现当前目录名称：

```
(env) D:\MyDesk\env\Scripts>
```
### linux
```
$ source ./env/bin/activate
```
**注：命令 `deactivate` 可退出虚拟环境，回到系统默认的 Python 解释器，包括已安装的库也会回到默认的。**

## 注意事项
### 冷冻（freeze）环境
为了保持您的环境的一致性，可冷冻（freeze）环境包当前的状态：
```
$ pip freeze > requirements.txt
```
这将会创建一个 requirements.txt 文件，其中包含了当前环境中所有包及各自的版本的简单列表。类似 npm 的 package.json 文件，当需要在以后安装相同版本的包时变得容易：
```
$ pip install -r requirements.txt
```
这可以确保安装、部署和开发之间的一致性。当然也可以使用 `pip list` 在不产生 requirements 文件的情况下，查看已安装包的列表。

### 排除虚拟环境
应在源码版本控制中排除掉虚拟环境文件夹，可在 ignore 列表中添加。

## 使用 virtualenvwrapper
virtualenvwrapper 提供了一系列命令使得和虚拟环境工作变得便捷。可将所有的虚拟环境都放在一个地方。执行下列命令安装（要确保 virtualenv 已经安装）：
```
$ pip install virtualenvwrapper
$ export WORKON_HOME=~/Envs
$ source /usr/local/bin/virtualenvwrapper.sh
```
[virtualenvwrapper 文档](https://virtualenvwrapper.readthedocs.io/en/latest/install.html)

对于 Windows，可以使用 virtualenvwrapper-win，执行下列命令安装（确保 virtualenv 已经安装了）：
```
$ pip install virtualenvwrapper-win
```
在 Windows 中，`WORKON_HOME` 默认的路径是 `%USERPROFILE%\Envs`

### 基本使用
创建一个虚拟环境：
```
$ mkvirtualenv my_project
```
这会在 ~/Envs 中创建 my_project 文件夹。

在虚拟环境上工作：
```
$ workon my_project
```
或者，您可以创建一个项目，它会创建虚拟环境，并在 $WORKON_HOME 中创建一个项目目录。 当您使用 workon myproject 时，会 cd 到项目目录中。
```
$ mkproject myproject
```
virtualenvwrapper 提供环境名字的tab补全功能。当您有很多环境， 并且很难记住它们的名字时，这就显得很有用。

workon 也能停止您当前所在的环境，所以您可以在环境之间快速的切换。

停止是一样的：
```
$ deactivate
```
删除：
```
$ rmvirtualenv my_project
```

### 其他有用的命令
- `lsvirtualenv` 列举所有的环境。
- `cdvirtualenv` 导航到当前激活的虚拟环境的目录中，比如说这样您就能够浏览它的 site-packages 。
- `cdsitepackages` 和上面的类似，但是是直接进入到 site-packages 目录中。
- `lssitepackages` 显示 site-packages 目录中的内容。

其他命令可参见：[virtualenvwrapper 命令的完整列表](https://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html)
