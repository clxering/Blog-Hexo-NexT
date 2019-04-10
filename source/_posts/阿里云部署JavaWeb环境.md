---
title: 阿里云部署 JavaWeb 环境
date: 2018-10-05 17:33:28
categories:
- 后端技术
tags:
- 服务器相关
---

> 摘要：记录了阿里云部署JavaWeb环境的步骤和流程，以及安装JDK/JRE、tomcat、MySQL时遇到的问题和解决方式。

<!-- more -->

## 环境、工具及版本
- 操作系统：CentOS 7
- JDK8
- SecureFX、SecureCRT

## 安装JDK/JRE示例
- 使用SecureFX连接服务器，将本地的jdk-8u171-linux-x64.tar.gz上传至root目录
- 在usr目录建立目录：java/jdk
- 使用SecureCRT进入root目录，执行命令：`tar zxvf jdk-8u171-linux-x64.tar.gz -C /usr/java/jdk`
- 解压完成后，进入etc目录，用SecureFX打开profile文件，在末尾添加内容后保存：
```
#set java environment
export JAVA_HOME=/usr/java/jdk/jdk1.8.0_171
export JRE_HOME=/usr/java/jdk/jdk1.8.0_171/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$JAVA_HOME:$PATH
```
- 使用SecureCRT输入命令：`source /etc/profile`，环境变量生效
- 输入命令：`java -version`，查看JDK是否安装成功，如果安装成功则显示版本号信息
```
java version "1.8.0_171"
Java(TM) SE Runtime Environment (build 1.8.0_171-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.171-b11, mixed mode)
```

## 安装tomcat示例
- 使用SecureFX连接服务器，将本地的apache-tomcat-7.0.88.tar.gz上传至root目录
- 在usr目录建立目录：java/tomcat
- 使用SecureCRT进入root目录，执行命令：`tar zxvf apache-tomcat-7.0.88.tar.gz  -C /usr/java/tomcat`
- 使用SecureFX进入tomcat目录的bin，编辑setclasspath.sh，在末尾添加内容后保存：
```
export JAVA_HOME=/usr/java/jdk/jdk1.8.0_171
export JRE_HOME=/usr/java/jdk/jdk1.8.0_171/jre
```
- 使用SecureCRT进入tomcat目录的bin，输入`./startup.sh`后即可启动tomcat，如果启动成功则显示以下信息：
```
[root@izwabcdefghijklh8jykfdz bin]# ./startup.sh
Using CATALINA_BASE:   /usr/java/tomcat/apache-tomcat-7.0.88
Using CATALINA_HOME:   /usr/java/tomcat/apache-tomcat-7.0.88
Using CATALINA_TMPDIR: /usr/java/tomcat/apache-tomcat-7.0.88/temp
Using JRE_HOME:        /usr/java/jdk/jdk1.8.0_171/jre
Using CLASSPATH:       /usr/java/tomcat/apache-tomcat-7.0.88/bin/bootstrap.jar:/usr/java/tomcat/apache-tomcat-7.0.88/bin/tomcat-juli.jar
Tomcat started.
```
- 在阿里云防火墙规则中开启8080端口

{% asset_img 1.png %}

- 7、此时在浏览器输入公网IP和端口号：`xxx.xxx.xxx.xxx：8080`，如果显示tomcat主页就说明部署完成

## 安装JDK和tomcat时编辑文件的说明
- 安装JDK和tomcat时，编辑profile文件、setclasspath.sh文件的步骤也可以用SecureCRT以vi命令操作文件，例如：`vi profile`、`vi setclasspath.sh`
- 命令模式。输入vi后进入命令模式，此状态下敲击键盘动作会被vi识别为命令，而非输入字符。这里会使用的常用命令：
  - `i` 切换到输入模式，此时可以输入字符
  - `x` 删除当前光标所在处的字符
  - `:`切换到底线命令模式
- 输入模式。在输入模式中，会主要使用以下按键：
  - HOME/END，移动光标到行首/行尾
  - Page Up/Page Down，上/下翻页
  - ESC，退出输入模式，切换到命令模式
- 底线命令模式。在命令模式下按下 ：可进入底线命令模式。底线命令模式可以输入单个或多个字符的命令，会主要使用以下命令：
  - `:q`  退出程序
  - `:w`  保存文件
  - `:q！` 退出不保存
  - `:wq`  退出并保存
>注：底线命令模式下按ESC键可退出。

## 安装MySQL示例
- 执行安装
```
#yum install mysql
#yum install mysql-server
#yum install mysql-devel
```
- 安装mysql-server时失败，因为CentOS 7将MySQL数据库软件从默认程序列表中移除，需要重新到官网下载
```
# wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
# rpm -ivh mysql-community-release-el7-5.noarch.rpm
# yum install mysql-community-server
```
- 安装成功后重启mysql服务。
```
# service mysqld restart
```
- 登录，此时首次登录不需要密码
```
# mysql -u root
```
- 修改密码
```
use mysql；
update user set password=PASSWORD("root")where user="root"；
```
- 更新权限
```
flush privileges；
```
- 重启服务
```
service mysqld restart
```
- 重新登录即可
```
mysql -u用户名 -p密码
```

## 安装MySQL时的问题

### ⭐ 远程访问错误

远程访问授权时出现如下错误：
`ERROR 1558 (HY000): Column count of mysql.user is wrong. Expected 43, found 42. Created with MySQL 50556, now running 50640. Please use mysql_upgrade to fix this error.`

#### 解决方案
- 退出至命令行，使用下列命令
```
[root@izwabcdefghijklh8jykfdz ~]# mysql_upgrade -uroot -p
Enter password:
```

- 输入密码后出现下列信息
```
Looking for 'mysql' as: mysql
Looking for 'mysqlcheck' as: mysqlcheck
Running 'mysqlcheck with default connection arguments
Warning: Using a password on the command line interface can be insecure.
Running 'mysqlcheck with default connection arguments
Warning: Using a password on the command line interface can be insecure.
mysql.columns_priv                                 OK
mysql.db                                           OK
mysql.event                                        OK
mysql.func                                         OK
mysql.general_log                                  OK
mysql.help_category                                OK
mysql.help_keyword                                 OK
mysql.help_relation                                OK
mysql.help_topic                                   OK
mysql.host                                         OK
mysql.ndb_binlog_index                             OK
mysql.plugin                                       OK
mysql.proc                                         OK
mysql.procs_priv                                   OK
mysql.proxies_priv                                 OK
mysql.servers                                      OK
mysql.slow_log                                     OK
mysql.tables_priv                                  OK
mysql.time_zone                                    OK
mysql.time_zone_leap_second                        OK
mysql.time_zone_name                               OK
mysql.time_zone_transition                         OK
mysql.time_zone_transition_type                    OK
mysql.user                                         OK
Running 'mysql_fix_privilege_tables'...
Warning: Using a password on the command line interface can be insecure.
Running 'mysqlcheck with default connection arguments
Warning: Using a password on the command line interface can be insecure.
Running 'mysqlcheck with default connection arguments
Warning: Using a password on the command line interface can be insecure.
OK
```

- 此时重新进行远程访问授权，成功
```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root' @'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
Query OK, 0 rows affected (0.00 sec)
```

## 其他设置
⭐ 创建用户mark，允许从ip为20.21.22.128的主机连接到mysql服务器，仅授权增删改查操作，使用123456作为密码
```
mysql>create user 'mark' @'%' identified by '123456';  
mysql>GRANT Select,Update,Insert,Delete PRIVILEGES ON *.* TO 'mark' @’20.21.22.128’ IDENTIFIED BY '123456' WITH GRANT OPTION;
```
> 有关

⭐ mysql配置文件位置：`/etc/my.cnf`
