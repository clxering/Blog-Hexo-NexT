---
title: MySQL问题记录备忘
date: 2019-03-28 20:59:37
categories:
- 后端技术
tags:
- MySQL
---

> 摘要：

<!-- more -->


## 一、压缩版安装（8.0+ 版本）
1、下载，解压至目标位置

2、配置环境变量

3、初始化
进入 bin 目录，用管理员权限打开 cmd 命令行，执行 `mysqld --initialize --console`，出现的随机密码 `,sDmQfi:f9u#`。

**注意：这个版本没有my.ini文件，因此我们无法通过在my.ini文件中更改配置跳过输入密码，因此我们需要通过–console命令来获取root的密码**

```
D:\mysql8.0.15\bin>mysqld --initialize --console
2019-03-27T01:01:24.504964Z 0 [System] [MY-013169] [Server] D:\mysql8.0.15\bin\mysqld.exe (mysqld 8.0.15) initializing of server in progress as process 11120
2019-03-27T01:01:50.726845Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: ,sDmQfi:f9u#
2019-03-27T01:02:01.062899Z 0 [System] [MY-013170] [Server] D:\mysql8.0.15\bin\mysqld.exe (mysqld 8.0.15) initializing of server has completed
```

4、安装mysql服务，运行命令 `net start mysql`

5、登录，命令 `mysql -u root -p`，输入之前的随机密码

6、修改密码
命令：`alter user 'root'@'localhost' Identified by '新密码';`


## 二、异常及报错的解决方案汇总
### ⭐ 数据库可视化客户端连接 MySQL 时出现 2058 错误
解决方法，修改加密方式。windows 下 cmd 登录 mysql 数据库，然后执行这条SQL：

`ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';`

password 是你自己设置的 root 密码；

8.0 采用了caching_sha2_password 加密方式，是 sha256 方式的改进，第三方客户端基本都不支持这种加密方式，但自带的命令行支持。

具体可参看官方文档说明：https://dev.mysql.com/doc/refman/8.0/en/upgrading-from-previous-series.html#upgrade-caching-sha2-password
