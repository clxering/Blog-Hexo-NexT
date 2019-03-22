---
title: 使用 Navicat 连接阿里云远程 MySQL 数据库
date: 2018-05-10 21:57:06
categories:
- 后端技术
tags:
- MySQL
---

> 摘要：记录使用Navicat连接阿里云远程MySQL数据库的流程，例举了其他与MySql用户权限设置的有关内容。

<!-- more -->

## 需求

使用 Navicat 连接阿里云远程 MySQL 数据库。

## 解决方案

### 1、开放权限

登录 MySql，此时用命令指定用户名 root 可以通过密码 123456 访问所有数据库，之后刷新权限。相应的命令及结果如下：

```
mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;  
Query OK, 0 rows affected (0.00 sec)  

mysql>FLUSH PRIVILEGES;  
Query OK, 0 rows affected (0.00 sec)   
```

### 2、设置服务器安全组的端口放行规则

**ECS云服务器安全组设置如下：**

![ECS云服务器安全组设置](https://upload-images.jianshu.io/upload_images/5492471-ecc92888bc39297f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**轻量应用服务器防火墙设置如下：**

![轻量应用服务器防火墙设置](https://upload-images.jianshu.io/upload_images/5492471-821647534bf36242.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 3、设置Navicat

进入 Navicat，新建连接，在「常规」选项卡中输入开放权限时的信息，用户名：root；密码：123456

![设置Navicat](https://upload-images.jianshu.io/upload_images/5492471-79f66eabf26b49dd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
