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
- CentOS Linux 7.4.1708 (Core)
- Corretto 11
- SecureFX、SecureCRT（可选）
- MySQL 5.1.47
- MySQL 8.0.15（可选）

## 安装 JDK/JRE 参考步骤
- 在 etc 下建立存放目录，可以用图形化工具建立，或者命令行：`mkdir /etc/java`
- 在 etc 下使用命令：`wget https://d3pxv6yz143wms.cloudfront.net/11.0.3.7.1/amazon-corretto-11.0.3.7.1-linux-x64.tar.gz`，或使用 SecureFX 连接服务器，将本地文件上传。
- 在 etc 下执行命令：`tar zxvf jdk-8u171-linux-x64.tar.gz -C /etc/java/`
- 解压完成后，在 etc 下修改 profile 文件，在末尾添加内容后保存：
```
#set java environment
export JAVA_HOME=/etc/java/amazon-corretto-11.0.3.7.1-linux-x64
export CLASSPATH=.:$JAVA_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JAVA_HOME:$PATH
```
**附加内容：若安装 JDK 8，环境变量设置可改为：**
```
#set java environment
export JAVA_HOME=/usr/java/jdk/jdk1.8.0_171
export JRE_HOME=/usr/java/jdk/jdk1.8.0_171/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$JAVA_HOME:$PATH
```
- 使用命令：`source /etc/profile`，让环境变量生效
- 输入命令：`java -version`，查看 JDK 是否安装成功，如果安装成功则显示版本号信息：
```
openjdk version "11.0.3" 2019-04-16 LTS
OpenJDK Runtime Environment Corretto-11.0.3.7.1 (build 11.0.3+7-LTS)
OpenJDK 64-Bit Server VM Corretto-11.0.3.7.1 (build 11.0.3+7-LTS, mixed mode)
```

## 安装 tomcat 参考步骤
- 使用 SecureFX 连接服务器，将本地的 `apache-tomcat-7.0.88.tar.gz` 上传至 root 目录
- 在 etc 下建立存放目录，可以用图形化工具建立，或者命令行：`mkdir /etc/tomcat`
- 使用 SecureCRT 进入 root 目录，执行命令：`tar zxvf apache-tomcat-7.0.88.tar.gz -C /etc/tomcat`
- 使用 SecureFX 进入 tomcat 目录的 bin，编辑 `setclasspath.sh`，在末尾添加内容后保存：
```
export JAVA_HOME=/etc/java/amazon-corretto-11.0.3.7.1-linux-x64
export JRE_HOME=/usr/java/jdk/jdk1.8.0_171/jre
```
**注：若安装 JDK 8 以上版本，已经不再有 JRE，而且 tomcat 7 也并不支持新版本。**
- 使用 SecureCRT 进入 tomcat 目录的 bin，输入 `./startup.sh` 后即可启动 tomcat，如果启动成功则显示以下信息：
```
[root@izwabcdefghijklh8jykfdz bin]# ./startup.sh
Using CATALINA_BASE:   /usr/java/tomcat/apache-tomcat-7.0.88
Using CATALINA_HOME:   /usr/java/tomcat/apache-tomcat-7.0.88
Using CATALINA_TMPDIR: /usr/java/tomcat/apache-tomcat-7.0.88/temp
Using JRE_HOME:        /usr/java/jdk/jdk1.8.0_171/jre
Using CLASSPATH:       /usr/java/tomcat/apache-tomcat-7.0.88/bin/bootstrap.jar:/usr/java/tomcat/apache-tomcat-7.0.88/bin/tomcat-juli.jar
Tomcat started.
```
- 在阿里云防火墙规则中开启 8080 端口

{% asset_img 1.png %}

- 7、此时在浏览器输入公网 IP 和端口号：`xxx.xxx.xxx.xxx：8080`，若显示 tomcat 主页就说明部署成功

## 安装 JDK 和 tomcat 时编辑文件的说明
- 安装 JDK 和 tomcat 时，编辑 profile 文件、setclasspath.sh 文件的步骤也可以用 SecureCRT 以 vi 命令操作文件，例如：`vi profile`、`vi setclasspath.sh`
- 命令模式。输入 vi 后进入命令模式，此状态下敲击键盘动作会被 vi 识别为命令，而非输入字符。这里会使用的常用命令：
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

**注：底线命令模式下按 ESC 键可退出。**

## 安装 MySQL 5.1.47 参考步骤
- 执行安装
```
#yum install mysql
#yum install mysql-server
#yum install mysql-devel
```
- 安装 mysql-server 时失败，因为 CentOS 7 将 MySQL 数据库软件从默认程序列表中移除，需要重新到官网下载
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

## 安装 MySQL 5.1.47 时的问题

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
⭐ 创建用户 mark，允许从 ip 为 20.21.22.128 的主机连接到 mysql 服务器，仅授权增删改查操作，使用 123456 作为密码
```
mysql>create user 'mark' @'%' identified by '123456';  
mysql>GRANT Select,Update,Insert,Delete PRIVILEGES ON *.* TO 'mark' @’20.21.22.128’ IDENTIFIED BY '123456' WITH GRANT OPTION;
```
> 有关用户访问权限的设置可参看我的另一篇文章：[MySql用户访问权限的设置](https://www.jianshu.com/p/1b17442edd38)

⭐ mysql 5.1.47 配置文件位置：`/etc/my.cnf`

## 安装 MySQL 8.0.15 参考步骤
- （可选步骤）移除 CentOS 7 默认安装的 mariaDB，执行命令：`yum remove mariadb-libs.x86_64`。执行该步骤需要获得 root 权限。
- 在 etc 下建立存放目录，可以用图形化工具建立，或者命令行：`mkdir /etc/mysql`
- 前往获取 [Yum Repository](https://dev.mysql.com/downloads/repo/yum/) 下载链接，选择 `mysql80-community-release-el7-2.noarch.rpm`

{% asset_img 2.png %}

- 进入下载页面后复制链接

{% asset_img 3.png %}

- 在命令行执行：`wget https://dev.mysql.com/get/mysql80-community-release-el7-2.noarch.rpm`，下载安装包。
- 执行 `yum localinstall mysql80-community-release-el7-2.noarch.rpm`，安装包将添加到本地 /home/admin 目录下。
- 可执行 `yum search mysql`，观察搜索结果是否有 mysql-community-server，存在则说明添加成功：

{% asset_img 4.png %}

- 执行命令：`yum install mysql-community-server` 安装服务。
- 执行命令：`service mysqld start` 启动服务，可执行 `service mysqld status` 查看服务是否启动成功：

{% asset_img 5.png %}

- 服务启动成功，执行命令 `cat /var/log/mysqld.log | grep password` 查看默认密码。
- 执行命令 `mysql -u root -p`，使用默认密码登陆。
- 登陆后可执行命令 `ALTER USER "root"@"localhost" IDENTIFIED BY "123456abcdeF";`，修改 root 默认密码为 123456abcdeF。

**附加内容：在 MySQL 8 中默认不能输入全数字的简单密码，需要进行如下设置：**
```
set global validate_password.policy=0;
set global validate_password.length=1;
```

## 重置密码
- 定位 /etc/my.cnf，在 my.cnf 文件 [mysqld] 下添加 `skip-grant-tables` 字符串，表示开启免密码登陆。
- 执行 `service mysqld restart`，重启服务，使配置生效。
- 执行 `mysql -u root -p`，无需键入内容，直接回车即可登录。
- 执行下列语句清空密码：
```
use mysql;
update user set authentication_string = '' where user = 'root';
```
- 成功后将 my.cnf 文件 [mysqld] 下添加 `skip-grant-tables` 字符串删除。

## 用户授权。
- 登陆后使用 mysql 数据库：`USE mysql`
- 例如：使用如下语句创建一个用户 test 密码为 123456
```
CREATE USER test IDENTIFIED BY '123456';
```
- 可使用下列语句查看下用户 test 的权限：
```
select * from user where user='test';
show grants for test;
```
- 下列语句给用户 test 在 database 数据库中对的所有表授权，如：EXECUTE（执行存储过程），INSERT，SELECT，UPDATE 权限，@'%' 表示来自任意 IP 的访问：
```
GRANT EXECUTE,INSERT,SELECT,UPDATE ON database.* TO 'test'@'%';
```
- 刷新权限：`flush privileges;`

## 开启外部第三方客户端连接权限。
- 8.0 采用了caching_sha2_password 加密，是 sha256 的改进版加密方式，多数第三方客户端都不支持这种加密方式，自带的命令行可支持。具体可参看 [官方文档](https://dev.mysql.com/doc/refman/8.0/en/upgrading-from-previous-series.html#upgrade-caching-sha2-password) 有关该内容说明。 要解决该问题，需要修改加密方式。

> 这里以 root 用户为例，如果要配置其他用户或授权 IP，对应修改名称和地址即可。password 是要设置的密码。
```    
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```
或者
```
update user set plugin='mysql_native_password' where user ='root';
```
- 为任意地址的第三方客户端开启权限：`ALTER USER "root"@"%" IDENTIFIED BY "123456";`

## 移除 MySQL
- 停止服务：`service mysqld stop`
- 执行 `rpm -qa | grep -i mysql` 查看 MySQL 组件，逐项执行移除完全为止。

{% asset_img 6.png %}

```
rpm -ev mysql-community-client-8.0.15-1.el7.x86_64
```
```
rpm -ev mysql-community-server-8.0.15-1.el7.x86_64
```
```
rpm -ev mysql-community-common-8.0.15-1.el7.x86_64
```
```
rpm -ev mysql-community-libs-8.0.15-1.el7.x86_64
```
- 删除相关目录。执行 `find / -name mysql`（查找） 和 `rm -rf xxx`（删除） 逐项执行移除完全为止。可能包含的目录如下：
```
/etc/logrotate.d/mysql
/etc/mysql
/var/lib/mysql
```

## nginx 1.16.0 的安装
nginx 中 gzip 模块需要 zlib 库，rewrite 模块需要 pcre 库，ssl 功能需要 openssl 库。以 `/usr/mix` 安装目录为例：

- 建立 mix 目录
```
$ mkdir mix
```
- 安装 GCC 和 GCC-C++
```
$ yum install gcc
$ yum install gcc-c++
```
> 注意：
若未安装 GCC，安装 Nginx 会报如下错误：
```
./configure: error: C compiler cc is not found
```
若未安装GCC-C++，安装 PCRE 库时报如下错误：
```
configure: error: You need a C++ compiler for C++ support.
```

- 编译安装 PCRE 库
```
$ cd /usr/
$ wget https://sourceforge.net/projects/pcre/files/pcre/8.43/pcre-8.43.tar.gz
$ tar -zxvf pcre-8.43.tar.gz -C /usr/mix/
$ cd mix/pcre-8.43
$ ./configure
$ make && make install
```
注意：这里使用 pcre 而不用 pcre2
- 编译安装 zlib 库
```
$ cd /usr/
$ wget http://www.zlib.net/zlib-1.2.11.tar.gz
$ tar -zxvf zlib-1.2.11.tar.gz -C /usr/mix/
$ cd mix/zlib-1.2.11
$ ./configure
$ make && make install
```
- 编译安装 openssl
```
$ cd /usr/
$ wget https://www.openssl.org/source/openssl-1.0.2r.tar.gz
$ tar -zxvf openssl-1.0.2r.tar.gz -C /usr/mix/
$ cd mix/openssl-1.0.2r
$ ./config
$ make && make install
```
- 编译安装 nginx，并添加 PCRE、zlib 、openssl 的源码路径
```
$ cd /usr/
$ wget http://nginx.org/download/nginx-1.16.0.tar.gz
$ tar -zxvf nginx-1.16.0.tar.gz -C /usr/mix/
$ cd mix/nginx-1.16.0
$ ./configure --prefix=/usr/mix/nginx --with-pcre=/usr/mix/pcre-8.43 --with-zlib=/usr/mix/zlib-1.2.11 --with-openssl=/usr/mix/openssl-1.0.2r
$ make && make install
```
- 启动 Nginx，默认端口为 80
```
$ ./usr/mix/nginx/sbin/nginx
```
- 查看工作情况
```
$ ps -ef | grep nginx
```
- 其他命令
```
./sbin/nginx -s reload            # 重新载入配置文件
./sbin/nginx -s reopen            # 重启 Nginx
./sbin/nginx -s stop              # 停止 Nginx
```

## 解压 filename.tar.xz 文件
使用命令：`tar  -xvf filename.tar.xz`

### 在 linux 服务器运行 jar 文件
通常的方法是：
```
$ java -jar test.jar
```
但是这种方式在 SSH 窗口关闭时程序将中止运行，或者是运行时没法切出去执行其他任务，有没有办法让 jar 在后台运行。要解决这个问题，可以使用：
```
$ nohup java -jar test.jar &
```
即不挂断运行命令，账户退出或终端关闭时，程序仍然运行。当用 nohup 命令执行作业时，缺省情况下该作业的所有输出被重定向到 nohup.out 的文件中，除非另外指定了输出文件。例如：
```
$ nohup java -jar test.jar >temp.txt &
```
此时把日志文件输入到指定的文件中，没有则会自动创建。
**附加内容：使用 nohup 时报错**
1、提示 `nohup: failed to run command `java': No such file or directory`
2、或者使用 ./startup.sh 开启tomcat服务报错：
```
Neither the JAVA_HOME nor the JRE_HOME environment variable is defined
At least one of these environment variable is needed to run this program
```
以上情况，执行一次 source /etc/profile 即可。

### nginx 设置反向代理后，页面上的 js css 文件无法加载
可添加如下配置：
```
location ~ .*\.(js|css)$ {
    proxy_pass http://127.0.0.1:8866;
}
```
完整示例：
```
listen 80;
server_name www.test.com;

location /{
    proxy_pass http://xxx.xxx.xxx.xxx:9002;
    index index.html;
    proxy_redirect off;
    proxy_set_header  Host  $host;
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;
}

location ~ .*\.(js|css)$ {
    proxy_pass http://xxx.xxx.xxx.xxx:9002;
}
```

### linux kill 命令
- 格式：kill [参数] [进程号]

### linux 查询端口情况
netstat 命令各个参数说明如下：
```
-t : 指明显示TCP端口
-u : 指明显示UDP端口
-l : 仅显示监听套接字(所谓套接字就是使应用程序能够读写与收发通讯协议(protocol)与资料的程序)
-p : 显示进程标识符和程序名称，每一个套接字/端口都属于一个程序。
-n : 不进行DNS轮询，显示IP(可以加速操作)
```
要显示当前服务器上所有端口及进程服务，与 grep 结合可查看某个具体端口及服务情况：
```
netstat -ntlp   //查看当前所有tcp端口
netstat -ntulp |grep 80   //查看所有80端口使用情况
netstat -ntulp | grep 3306   //查看所有3306端口使用情况
```
查询出来的结果，根据 ID 号可以用 kill 命令终止后台运行的任务。

### 其他命令
- jobs 命令：查看当前终端后台运行的任务，jobs 的状态可以是 running，stopped，Terminated。`+` 号表示当前任务，`-` 号表示后一个任务。注：该命令可在使用 nohup 后紧接使用。
