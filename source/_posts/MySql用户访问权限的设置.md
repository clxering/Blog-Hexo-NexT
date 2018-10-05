---
title: MySql用户访问权限的设置
date: 2018-10-05 18:10:06
categories:
- 后端技术
tags:
- MySQL
---

> 摘要：记录了MySql用户访问权限的设置方式。

<!-- more -->

⭐ 设置访问单个数据库权限
```
mysql>grant all privileges on test.* to 'root'@'%';
```

设置用户名为root，密码为空，可访问数据库test

⭐ 设置访问全部数据库权限
```
mysql>grant all privileges on *.* to 'root'@'%';
```
设置用户名为root，密码为空，可访问所有数据库*


⭐ 设置指定用户名访问权限
```
mysql>grant all privileges on *.* to 'root'@'%';
```
设置指定用户名为root，密码为空，可访问所有数据库*

⭐ 设置密码访问权限
```
mysql>grant all privileges on *.* to 'root'@'%' IDENTIFIED BY '123456';
```
设置指定用户名为root，密码为123456，可访问所有数据库*


⭐ 设置指定可访问主机权限
```
mysql>grant all privileges on *.* to 'root'@'11.1.1.1';
```
设置指定用户名为root，可访问所有数据库*，只有11.1.1.1这台机器有权限访问
