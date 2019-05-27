---
title: MySQL 用户访问权限的设置
date: 2019-04-23 18:10:06
categories:
- 后端技术
tags:
- MySQL
---

> 摘要：记录了 MySql 用户访问权限的设置方式。

<!-- more -->

⭐ 查看数据库中的所有用户
```
SELECT DISTINCT CONCAT('User: ''',user,'''@''',host,''';') AS query FROM mysql.user;
```

⭐ 查看数据库中具体某个用户的权限:
```
show grants for 'root'@'localhost';
```

⭐ 取消来自远程服务器的 AA 用户所有数据库的所有的表的权限
```
revoke all privileges on *.* from AA@"%";
```
⭐ 取消来自远程服务器的 AA 用户对数据库 db 里的表 tb 的所有权限
```
revoke all on db.tb from AA@"%";
```
⭐ 取消来自远程服务器的 AA 用户对数据库 db 的所有表的所有权限
```
revoke all on db.* from AA@"%";
```

⭐ 为来自 11.1.1.1 的用户 AA 分配可对数据库 db 的表 tb 进行 select，insert，update，delete，create，drop 的权限，并设密码为 123456
```
grant select,insert,update,delete,create,drop on db1.tb1 to AA@11.1.1.1 identified by '123456';
```

⭐ 为来自 11.1.1.1 的 AA 用户分配可对数据库 db 所有表进行所有操作的权限，密码 123456
```
grant all privileges on db1.* to AA@11.1.1.1 identified by '123456';
```

⭐ 为来自 11.1.1.1 的 AA 用户分配可对所有数据库的所有表进行所有操作的权限，密码 123456
```
grant all privileges on *.* to AA@11.1.1.1 identified by '123456';
```

注意：赋予权限的时候不指定来自哪个远程服务器，只需用 % 替代远程主机地址即可。
