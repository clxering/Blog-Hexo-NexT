---
title: MySQL 问题记录备忘
date: 2019-03-28 20:59:37
categories:
- 后端技术
tags:
- MySQL
---

> 摘要：记录了 MySQL 使用过程中出现的问题及解决方案。

<!-- more -->

## 一、压缩版安装（8.0.15 版本）
1. 下载，解压至目标位置
2. 配置环境变量
3. 初始化
进入 bin 目录，用管理员权限打开 cmd 命令行，执行 `mysqld --initialize --console`，出现的随机密码 `,sDmQfi:f9u#`。如下所示：
> **注意：8.0.15 版本没有 my.ini 文件，因此无法通过在 my.ini 文件中更改配置跳过输入密码，需要通过 –console 命令来获取 root 的密码**

```
D:\mysql8.0.15\bin>mysqld --initialize --console
2019-03-27T01:01:24.504964Z 0 [System] [MY-013169] [Server] D:\mysql8.0.15\bin\mysqld.exe (mysqld 8.0.15) initializing of server in progress as process 11120
2019-03-27T01:01:50.726845Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: ,sDmQfi:f9u#
2019-03-27T01:02:01.062899Z 0 [System] [MY-013170] [Server] D:\mysql8.0.15\bin\mysqld.exe (mysqld 8.0.15) initializing of server has completed
```

4、安装mysql服务，运行命令 `net start mysql`
**附加内容：执行 `net start mysql` 时提示：**
```
服务名无效。

请键入 NET HELPMSG 2185 以获得更多的帮助。
```
此时重新安装服务即可：`mysqld -install`

5、登录，命令 `mysql -u root -p`，输入之前的随机密码

6、修改密码
命令：`alter user 'root'@'localhost' Identified by '新密码';`

## 二、异常及报错的解决方案汇总
### ⭐ 数据库可视化客户端连接 MySQL 时出现 2058 错误
8.0 采用了caching_sha2_password 加密，是 sha256 的改进版加密方式，多数第三方客户端都不支持这种加密方式，自带的命令行可支持。具体可参看 [官方文档](https://dev.mysql.com/doc/refman/8.0/en/upgrading-from-previous-series.html#upgrade-caching-sha2-password) 有关该内容说明。 要解决该问题，需要修改加密方式。以 windows 系统为例：用管理员身份开启 cmd，登录 mysql 数据库后执行下列命令：

> 这里以 root 用户为例，如果要配置其他用户或授权 IP，对应修改名称和地址即可。password 是要设置的密码。

```
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```


### ⭐ linux 下请求数据发送后显示为乱码
- 使用如下命令查看数据库字符集
```
show variables like ‘char%’
```
- 例如，database 的编码方式是 latin1，server 的编码方式也是 latin1。尝试使用下列命令修改：
```
set character_set_database=utf8;
set character_set_server=utf8;
```
- 如果不成功，则需要修改 my.cnf 文件，进入所在目录，执行下列命令：
```
ls -l | grep my.cnf
```
- 若 my.cnf 文件不存在，需要到 Mysql 配置文件路径路径 /usr/share/mysql 下复制。假设要从 /etc 中复制 my-default.cnf 文件，并将文件改名为 my.cnf，执行以下命令：
```
cd /etc
cp /usr/share/mysql/my-default.cnf my.cnf
```
- 可对文件进行备份：
```
cp my.cnf my.cnf.bak
```
- 打开文件：
```
sudo vi my.cnf
```
- 在 [mysqld] 附近加入配置：
```
[client]  
default-character-set=utf8
```
- 在 [mysqld] 末位加入下列内容：
```
default-storage-engine=INNODB  
character-set-server=utf8
collation-server=utf8_general_ci
```
- 保存退出，重启 Mysql，再重新查看字符集，修改成功。
```
sudo service mysql restart
```


### ⭐linux 下配置文件 my.cnf 解释（参考）
```
#BEGIN CONFIG INFO
#DESCR: 4GB RAM, 只使用InnoDB, ACID, 少量的连接, 队列负载大
#TYPE: SYSTEM
#END CONFIG INFO
#
# 此mysql配置文件例子针对4G内存，并在两个日ip 2w ,pv 20w 测试过的。
# 主要使用INNODB
#处理复杂队列并且连接数量较少的mysql服务器
#
# 将此文件复制到/etc/my.cnf 作为全局设置,
# mysql-data-dir/my.cnf 作为服务器指定设置
# (@localstatedir@ for this installation) 或者放入
# ~/.my.cnf 作为用户设置.

# 在此配置文件中, 你可以使用所有程序支持的长选项.
# 如果想获悉程序支持的所有选项
# 请在程序后加上”–help”参数运行程序.
#
# 关于独立选项更多的细节信息可以在手册内找到
#

#
# 以下选项会被MySQL客户端应用读取.
# 注意只有MySQL附带的客户端应用程序保证可以读取这段内容.
# 如果你想你自己的MySQL应用程序获取这些值
# 需要在MySQL客户端库初始化的时候指定这些选项

#
[client]
#password = [your_password]
port = @MYSQL_TCP_PORT@
socket = @MYSQL_UNIX_ADDR@

# *** 应用定制选项 ***

#
# MySQL 服务端
#
[mysqld]

# 一般配置选项
port = @MYSQL_TCP_PORT@
socket = @MYSQL_UNIX_ADDR@

# back_log 是操作系统在监听队列中所能保持的连接数,
# 队列保存了在MySQL连接管理器线程处理之前的连接.
# 如果你有非常高的连接率并且出现”connection refused” 报错,
# 你就应该增加此处的值.
# 检查你的操作系统文档来获取这个变量的最大值.
# 如果将back_log设定到比你操作系统限制更高的值,将会没有效果
back_log = 50

# 不在TCP/IP端口上进行监听.
# 如果所有的进程都是在同一台服务器连接到本地的mysqld,
# 这样设置将是增强安全的方法
# 所有mysqld的连接都是通过Unix sockets 或者命名管道进行的.
# 注意在windows下如果没有打开命名管道选项而只是用此项
# (通过 “enable-named-pipe” 选项) 将会导致mysql服务没有任何作用!
#skip-networking

# MySQL 服务所允许的同时会话数的上限
# 其中一个连接将被SUPER权限保留作为管理员登录.
# 即便已经达到了连接数的上限.
max_connections = 100
# 每个客户端连接最大的错误允许数量,如果达到了此限制.
# 这个客户端将会被MySQL服务阻止直到执行了”FLUSH HOSTS” 或者服务重启
# 非法的密码以及其他在链接时的错误会增加此值.
# 查看 “Aborted_connects” 状态来获取全局计数器.
max_connect_errors = 10

# 所有线程所打开表的数量.
# 增加此值就增加了mysqld所需要的文件描述符的数量
# 这样你需要确认在[mysqld_safe]中 “open-files-limit” 变量设置打开文件数量允许至少4096
table_cache = 2048

# 允许外部文件级别的锁. 打开文件锁会对性能造成负面影响
# 所以只有在你在同样的文件上运行多个数据库实例时才使用此选项(注意仍会有其他约束!)
# 或者你在文件层面上使用了其他一些软件依赖来锁定MyISAM表
#external-locking

# 服务所能处理的请求包的最大大小以及服务所能处理的最大的请求大小(当与大的BLOB字段一起工作时相当必要)
# 每个连接独立的大小.大小动态增加
max_allowed_packet = 16M

# 在一个事务中binlog为了记录SQL状态所持有的cache大小
# 如果你经常使用大的,多声明的事务,你可以增加此值来获取更大的性能.
# 所有从事务来的状态都将被缓冲在binlog缓冲中然后在提交后一次性写入到binlog中
# 如果事务比此值大, 会使用磁盘上的临时文件来替代.
# 此缓冲在每个连接的事务第一次更新状态时被创建
binlog_cache_size = 1M

# 独立的内存表所允许的最大容量.
# 此选项为了防止意外创建一个超大的内存表导致永尽所有的内存资源.
max_heap_table_size = 64M

# 排序缓冲被用来处理类似ORDER BY以及GROUP BY队列所引起的排序
# 如果排序后的数据无法放入排序缓冲,
# 一个用来替代的基于磁盘的合并分类会被使用
# 查看 “Sort_merge_passes” 状态变量.
# 在排序发生时由每个线程分配
sort_buffer_size = 8M

# 此缓冲被使用来优化全联合(full JOINs 不带索引的联合).
# 类似的联合在极大多数情况下有非常糟糕的性能表现,
# 但是将此值设大能够减轻性能影响.
# 通过 “Select_full_join” 状态变量查看全联合的数量
# 当全联合发生时,在每个线程中分配
join_buffer_size = 8M

# 我们在cache中保留多少线程用于重用
# 当一个客户端断开连接后,如果cache中的线程还少于thread_cache_size,
# 则客户端线程被放入cache中.
# 这可以在你需要大量新连接的时候极大的减少线程创建的开销
# (一般来说如果你有好的线程模型的话,这不会有明显的性能提升.)
thread_cache_size = 8

# 此允许应用程序给予线程系统一个提示在同一时间给予渴望被运行的线程的数量.
# 此值只对于支持 thread_concurrency() 函数的系统有意义( 例如Sun Solaris).
# 你可可以尝试使用 [CPU数量]*(2..4) 来作为thread_concurrency的值
thread_concurrency = 8

# 查询缓冲常被用来缓冲 SELECT 的结果并且在下一次同样查询的时候不再执行直接返回结果.
# 打开查询缓冲可以极大的提高服务器速度, 如果你有大量的相同的查询并且很少修改表.
# 查看 “Qcache_lowmem_prunes” 状态变量来检查是否当前值对于你的负载来说是否足够高.
# 注意: 在你表经常变化的情况下或者如果你的查询原文每次都不同,
# 查询缓冲也许引起性能下降而不是性能提升

query_cache_size = 64M

# 只有小于此设定值的结果才会被缓冲
# 此设置用来保护查询缓冲,防止一个极大的结果集将其他所有的查询结果都覆盖.
query_cache_limit = 2M

# 被全文检索索引的最小的字长.
# 你也许希望减少它,如果你需要搜索更短字的时候.
# 注意在你修改此值之后,
# 你需要重建你的 FULLTEXT 索引
ft_min_word_len = 4

# 如果你的系统支持 memlock() 函数,你也许希望打开此选项用以让运行中的mysql在在内存高度紧张的时候,数据在内存中保持锁定并且防止可能被swapping out
# 此选项对于性能有益
#memlock

# 当创建新表时作为默认使用的表类型,
# 如果在创建表示没有特别执行表类型,将会使用此值
default_table_type = MYISAM

# 线程使用的堆大小. 此容量的内存在每次连接时被预留.
# MySQL 本身常不会需要超过64K的内存
# 如果你使用你自己的需要大量堆的UDF函数
# 或者你的操作系统对于某些操作需要更多的堆,
# 你也许需要将其设置的更高一点.
thread_stack = 192K

# 设定默认的事务隔离级别.可用的级别如下:
# READ-UNCOMMITTED, READ-COMMITTED, REPEATABLE-READ, SERIALIZABLE
transaction_isolation = REPEATABLE-READ

# 内部(内存中)临时表的最大大小
# 如果一个表增长到比此值更大,将会自动转换为基于磁盘的表.
# 此限制是针对单个表的,而不是总和.
tmp_table_size = 64M

# 打开二进制日志功能.
# 在复制(replication)配置中,作为MASTER主服务器必须打开此项
# 如果你需要从你最后的备份中做基于时间点的恢复,你也同样需要二进制日志.
log-bin=mysql-bin

# 如果你在使用链式从服务器结构的复制模式 (A->B->C),
# 你需要在服务器B上打开此项.
# 此选项打开在从线程上重做过的更新的日志,
# 并将其写入从服务器的二进制日志.
#log_slave_updates

# 打开全查询日志. 所有的由服务器接收到的查询 (甚至对于一个错误语法的查询)
# 都会被记录下来. 这对于调试非常有用, 在生产环境中常常关闭此项.
#log

# 将警告打印输出到错误log文件. 如果你对于MySQL有任何问题
# 你应该打开警告log并且仔细审查错误日志,查出可能的原因.
#log_warnings

# 记录慢速查询. 慢速查询是指消耗了比 “long_query_time” 定义的更多时间的查询.
# 如果 log_long_format 被打开,那些没有使用索引的查询也会被记录.
# 如果你经常增加新查询到已有的系统内的话. 一般来说这是一个好主意,
log_slow_queries

# 所有的使用了比这个时间(以秒为单位)更多的查询会被认为是慢速查询.
# 不要在这里使用”1″, 否则会导致所有的查询,甚至非常快的查询页被记录下来(由于MySQL 目前时间的精确度只能达到秒的级别).
long_query_time = 2

# 在慢速日志中记录更多的信息.
# 一般此项最好打开.
# 打开此项会记录使得那些没有使用索引的查询也被作为到慢速查询附加到慢速日志里
log_long_format

# 此目录被MySQL用来保存临时文件.例如,
# 它被用来处理基于磁盘的大型排序,和内部排序一样.
# 以及简单的临时表.
# 如果你不创建非常大的临时文件,将其放置到 swapfs/tmpfs 文件系统上也许比较好
# 另一种选择是你也可以将其放置在独立的磁盘上.
# 你可以使用”;”来放置多个路径
# 他们会按照roud-robin方法被轮询使用.
#tmpdir = /tmp

# *** 复制有关的设置

# 唯一的服务辨识号,数值位于 1 到 2^32-1之间.
# 此值在master和slave上都需要设置.
# 如果 “master-host” 没有被设置,则默认为1, 但是如果忽略此选项,MySQL不会作为master生效.
server-id = 1

# 复制的Slave (去掉master段的注释来使其生效)
#
# 为了配置此主机作为复制的slave服务器,你可以选择两种方法:
#
# 1) 使用 CHANGE MASTER TO 命令 (在我们的手册中有完整描述) -
# 语法如下:
#
# CHANGE MASTER TO MASTER_HOST=, MASTER_PORT= ,
# MASTER_USER=, MASTER_PASSWORD= ;
#
# 你需要替换掉 , , 等被尖括号包围的字段以及使用master的端口号替换 (默认3306).
#
# 例子:
#
# CHANGE MASTER TO MASTER_HOST=’125.564.12.1′, MASTER_PORT=3306,
# MASTER_USER=’joe’, MASTER_PASSWORD=’secret’;
#
# 或者
#
# 2) 设置以下的变量. 不论如何, 在你选择这种方法的情况下, 然后第一次启动复制(甚至不成功的情况下,
# 例如如果你输入错密码在master-password字段并且slave无法连接),
# slave会创建一个 master.info 文件,并且之后任何对于包含在此文件内的参数的变化都会被忽略
# 并且由 master.info 文件内的内容覆盖, 除非你关闭slave服务, 删除 master.info 并且重启slave 服务.
# 由于这个原因,你也许不想碰一下的配置(注释掉的) 并且使用 CHANGE MASTER TO (查看上面) 来代替
#
# 所需要的唯一id号位于 2 和 2^32 – 1之间
# (并且和master不同)
# 如果master-host被设置了.则默认值是2
# 但是如果省略,则不会生效
#server-id = 2
#
# 复制结构中的master – 必须
#master-host =
#
# 当连接到master上时slave所用来认证的用户名 – 必须
#master-user =
#
# 当连接到master上时slave所用来认证的密码 – 必须
#master-password =

# master监听的端口.
# 可选 – 默认是3306
#master-port =

# 使得slave只读.只有用户拥有SUPER权限和在上面的slave线程能够修改数据.
# 你可以使用此项去保证没有应用程序会意外的修改slave而不是master上的数据
#read_only

#*** MyISAM 相关选项

# 关键词缓冲的大小, 一般用来缓冲MyISAM表的索引块.
# 不要将其设置大于你可用内存的30%,
# 因为一部分内存同样被OS用来缓冲行数据
# 甚至在你并不使用MyISAM 表的情况下, 你也需要仍旧设置起 8-64M 内存由于它同样会被内部临时磁盘表使用.
key_buffer_size = 32M

# 用来做MyISAM表全表扫描的缓冲大小.
# 当全表扫描需要时,在对应线程中分配.
read_buffer_size = 2M

# 当在排序之后,从一个已经排序好的序列中读取行时,行数据将从这个缓冲中读取来防止磁盘寻道.
# 如果你增高此值,可以提高很多ORDER BY的性能.
# 当需要时由每个线程分配
read_rnd_buffer_size = 16M

# MyISAM 使用特殊的类似树的cache来使得突发插入
# (这些插入是,INSERT … SELECT, INSERT … VALUES (…), (…), …, 以及 LOAD DATA
# INFILE) 更快. 此变量限制每个进程中缓冲树的字节数.
# 设置为 0 会关闭此优化.
# 为了最优化不要将此值设置大于 “key_buffer_size”.
# 当突发插入被检测到时此缓冲将被分配.
bulk_insert_buffer_size = 64M

# 此缓冲当MySQL需要在 REPAIR, OPTIMIZE, ALTER 以及 LOAD DATA INFILE 到一个空表中引起重建索引时被分配.
# 这在每个线程中被分配.所以在设置大值时需要小心.
myisam_sort_buffer_size = 128M

# MySQL重建索引时所允许的最大临时文件的大小 (当 REPAIR, ALTER TABLE 或者 LOAD DATA INFILE).
# 如果文件大小比此值更大,索引会通过键值缓冲创建(更慢)
myisam_max_sort_file_size = 10G

# 如果被用来更快的索引创建索引所使用临时文件大于制定的值,那就使用键值缓冲方法.
# 这主要用来强制在大表中长字串键去使用慢速的键值缓冲方法来创建索引.
myisam_max_extra_sort_file_size = 10G

# 如果一个表拥有超过一个索引, MyISAM 可以通过并行排序使用超过一个线程去修复他们.
# 这对于拥有多个CPU以及大量内存情况的用户,是一个很好的选择.
myisam_repair_threads = 1

# 自动检查和修复没有适当关闭的 MyISAM 表.
myisam_recover

# 默认关闭 Federated
skip-federated

# *** BDB 相关选项 ***

# 如果你运行的MySQL服务有BDB支持但是你不准备使用的时候使用此选项. 这会节省内存并且可能加速一些事.
skip-bdb

# *** INNODB 相关选项 ***

# 如果你的MySQL服务包含InnoDB支持但是并不打算使用的话,
# 使用此选项会节省内存以及磁盘空间,并且加速某些部分
#skip-innodb

# 附加的内存池被InnoDB用来保存 metadata 信息
# 如果InnoDB为此目的需要更多的内存,它会开始从OS这里申请内存.
# 由于这个操作在大多数现代操作系统上已经足够快, 你一般不需要修改此值.
# SHOW INNODB STATUS 命令会显示当先使用的数量.
innodb_additional_mem_pool_size = 16M

# InnoDB使用一个缓冲池来保存索引和原始数据, 不像 MyISAM.
# 这里你设置越大,你在存取表里面数据时所需要的磁盘I/O越少.
# 在一个独立使用的数据库服务器上,你可以设置这个变量到服务器物理内存大小的80%
# 不要设置过大,否则,由于物理内存的竞争可能导致操作系统的换页颠簸.
# 注意在32位系统上你每个进程可能被限制在 2-3.5G 用户层面内存限制,
# 所以不要设置的太高.
innodb_buffer_pool_size = 2G

# InnoDB 将数据保存在一个或者多个数据文件中成为表空间.
# 如果你只有单个逻辑驱动保存你的数据,一个单个的自增文件就足够好了.
# 其他情况下.每个设备一个文件一般都是个好的选择.
# 你也可以配置InnoDB来使用裸盘分区 – 请参考手册来获取更多相关内容
innodb_data_file_path = ibdata1:10M:autoextend

# 设置此选项如果你希望InnoDB表空间文件被保存在其他分区.
# 默认保存在MySQL的datadir中.
#innodb_data_home_dir =

# 用来同步IO操作的IO线程的数量. This value is
# 此值在Unix下被硬编码为4,但是在Windows磁盘I/O可能在一个大数值下表现的更好.
innodb_file_io_threads = 4

# 如果你发现InnoDB表空间损坏, 设置此值为一个非零值可能帮助你导出你的表.
# 从1开始并且增加此值知道你能够成功的导出表.
#innodb_force_recovery=1

# 在InnoDb核心内的允许线程数量.
# 最优值依赖于应用程序,硬件以及操作系统的调度方式.
# 过高的值可能导致线程的互斥颠簸.
innodb_thread_concurrency = 16

# 如果设置为1 ,InnoDB会在每次提交后刷新(fsync)事务日志到磁盘上,
# 这提供了完整的ACID行为.
# 如果你愿意对事务安全折衷, 并且你正在运行一个小的食物, 你可以设置此值到0或者2来减少由事务日志引起的磁盘I/O
# 0代表日志只大约每秒写入日志文件并且日志文件刷新到磁盘.
# 2代表日志写入日志文件在每次提交后,但是日志文件只有大约每秒才会刷新到磁盘上.
innodb_flush_log_at_trx_commit = 1

# 加速InnoDB的关闭. 这会阻止InnoDB在关闭时做全清除以及插入缓冲合并.
# 这可能极大增加关机时间, 但是取而代之的是InnoDB可能在下次启动时做这些操作.
#innodb_fast_shutdown

# 用来缓冲日志数据的缓冲区的大小.
# 当此值快满时, InnoDB将必须刷新数据到磁盘上.
# 由于基本上每秒都会刷新一次,所以没有必要将此值设置的太大(甚至对于长事务而言)

innodb_log_buffer_size = 8M

# 在日志组中每个日志文件的大小

# 你应该设置日志文件总合大小到你缓冲池大小的25%~100%
# 来避免在日志文件覆写上不必要的缓冲池刷新行为.
# 不论如何, 请注意一个大的日志文件大小会增加恢复进程所需要的时间.
innodb_log_file_size = 256M

# 在日志组中的文件总数.
# 通常来说2~3是比较好的.
innodb_log_files_in_group = 3

# InnoDB的日志文件所在位置. 默认是MySQL的datadir.
# 你可以将其指定到一个独立的硬盘上或者一个RAID1卷上来提高其性能
#innodb_log_group_home_dir

# 在InnoDB缓冲池中最大允许的脏页面的比例.
# 如果达到限额, InnoDB会开始刷新他们防止他们妨碍到干净数据页面.
# 这是一个软限制,不被保证绝对执行.
innodb_max_dirty_pages_pct = 90

# InnoDB用来刷新日志的方法.
# 表空间总是使用双重写入刷新方法
# 默认值是 “fdatasync”, 另一个是 “O_DSYNC”.
#innodb_flush_method=O_DSYNC

# 在被回滚前,一个InnoDB的事务应该等待一个锁被批准多久.
# InnoDB在其拥有的锁表中自动检测事务死锁并且回滚事务.
# 如果你使用 LOCK TABLES 指令, 或者在同样事务中使用除了InnoDB以外的其他事务安全的存储引擎
# 那么一个死锁可能发生而InnoDB无法注意到.
# 这种情况下这个timeout值对于解决这种问题就非常有帮助.
innodb_lock_wait_timeout = 120

[mysqldump]
# 不要在将内存中的整个结果写入磁盘之前缓存. 在导出非常巨大的表时需要此项
quick

max_allowed_packet = 16M

[mysql]
no-auto-rehash

# 仅仅允许使用键值的 UPDATEs 和 DELETEs .
#safe-updates

[isamchk]
key_buffer = 512M
sort_buffer_size = 512M
read_buffer = 8M
write_buffer = 8M

[myisamchk]
key_buffer = 512M
sort_buffer_size = 512M
read_buffer = 8M
write_buffer = 8M

[mysqlhotcopy]
interactive-timeout

[mysqld_safe]
# 增加每个进程的可打开文件数量.
# 警告: 确认你已经将全系统限制设定的足够高!
# 打开大量表需要将此值设b
open-files-limit = 8192
```

### ⭐ 查看配置文件位置
```
which mysql
```

### ⭐ SpringBoot 连接 MySql 8.x 时出现 `CLIENT_PLUGIN_AUTH is required` 异常
修改 mysql-connector-java 依赖版本为低版本，如：
```
// https://mvnrepository.com/artifact/mysql/mysql-connector-java
compile group: 'mysql', name: 'mysql-connector-java', version: '5.1.47'
```

### 执行 mysql 命令时提示 command not found 的解决办法
在 etc/profile 添加环境变量即可，如下：
```
#set mysql environment
export MYSQL_HOME=/usr/java/mysql-8.0.15
export CLASSPATH=.:$MYSQL_HOME/lib:$CLASSPATH
export PATH=$MYSQL_HOME/bin:$MYSQL_HOME:$PATH
```

## MySQL 8.0.15 报 BEGIN NESTED EXCEPTION 警告
可能会导致连接关闭，数据库 URL 需要声明是否使用 SSL 安全验证及指定服务器上的时区，将 useSSL 设置为 false，即：`?useSSL=false&serverTimezone=UTC"`
```
Sun May 12 22:08:48 CST 2019 WARN: Caught while disconnecting...

EXCEPTION STACK TRACE:

** BEGIN NESTED EXCEPTION **

javax.net.ssl.SSLException
MESSAGE: closing inbound before receiving peer's close_notify

STACKTRACE:

javax.net.ssl.SSLException: closing inbound before receiving peer's close_notify
	at java.base/sun.security.ssl.Alert.createSSLException(Alert.java:133)
	at java.base/sun.security.ssl.Alert.createSSLException(Alert.java:117)
	at java.base/sun.security.ssl.TransportContext.fatal(TransportContext.java:308)
	at java.base/sun.security.ssl.TransportContext.fatal(TransportContext.java:264)
	at java.base/sun.security.ssl.TransportContext.fatal(TransportContext.java:255)
	at java.base/sun.security.ssl.SSLSocketImpl.shutdownInput(SSLSocketImpl.java:645)
	at java.base/sun.security.ssl.SSLSocketImpl.shutdownInput(SSLSocketImpl.java:624)
	at com.mysql.cj.protocol.a.NativeProtocol.quit(NativeProtocol.java:1319)
	at com.mysql.cj.NativeSession.quit(NativeSession.java:182)
	at com.mysql.cj.jdbc.ConnectionImpl.realClose(ConnectionImpl.java:1750)
	at com.mysql.cj.jdbc.ConnectionImpl.close(ConnectionImpl.java:720)
	at com.zaxxer.hikari.pool.PoolBase.quietlyCloseConnection(PoolBase.java:132)
	at com.zaxxer.hikari.pool.HikariPool.lambda$closeConnection$1(HikariPool.java:434)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
	at java.base/java.lang.Thread.run(Thread.java:834)


** END NESTED EXCEPTION **
```

## MySQL 8.0.15 驱动类名称
旧版驱动类是com.mysql.jdbc.Driver，但是如果你在8.0还继续用这个类，就会提示你：

Loading class `com.mysql.jdbc.Driver'. This is deprecated. The new driver class is `com.mysql.cj.jdbc.Driver'. The driver is automatically registered via the SPI and manual loading of the driver class is generally unnecessary.
所以我们需要用新的驱动类，在配置文件中改为：

driver=com.mysql.cj.jdbc.Driver

## MySQL 8.0.15 时区
现在我们虽然填对了驱动类，但是又有一个新的报错：

java.sql.SQLException: The server time zone value 'ÖÐ¹ú±ê×¼Ê±¼ä' is unrecognized or represents more than one time zone. You must configure either the server or JDBC driver (via the serverTimezone configuration property) to use a more specifc time zone value if you want to utilize time zone support.
这里就需要我们手动指定时区，如果你的服务器也是东八区（GMT+8），那么在URL后面加上参数serverTimezone=GMT%2B8即可：

url=jdbc:mysql://localhost:3306/test?serverTimezone=GMT%2B8

## MySQL 8.0.15 SSL
之后还有一个在关闭连接对象时会产生的一个无关紧要的报错，不解决也可以正常使用，但是占据控制台的大量篇幅，导致使用体验极差：

javax.net.ssl.SSLException
MESSAGE: closing inbound before receiving peer's close_notify
MySQL 8.0开始，数据库URL需要设置是否使用SSL安全连接，在URL后面加上参数useSSL=false即可，多个参数键值对中间用&隔开：

url=jdbc:mysql://localhost:3306/test?serverTimezone=GMT%2B8&useSSL=false

## MySQL 8.0.15 Public Key Retrieval报错
重启服务器后悔出现Public Key Retrieval报错：

java.sql.SQLNonTransientConnectionException: Public Key Retrieval is not allowed
在URL后加上allowPublicKeyRetrieval=true即可

url=jdbc:mysql://localhost:3306/test?serverTimezone=GMT%2B8&useSSL=false&allowPublicKeyRetrieval=true

## MySQL 8.0.15 getTables默认返回所有库的表
8.0及以上版本的驱动默认将nullCatalogMeansCurrent的默认值由true改为了false，如果使用DatabaseMetaData类的对象调用getTables方法，就会返回所有库的表，而非在url参数中指定的数据库（本例中数据库名为test）。此时就需要手动在参数中指定nullCatalogMeansCurrent值为true：

url=jdbc:mysql://localhost:3306/test?serverTimezone=GMT%2B8&useSSL=false&useSSL=false&allowPublicKeyRetrieval=true&nullCatalogMeansCurrent=true

## 查看当前使用的数据库
```
mysql>select database();
mysql>status;
mysql>show tables;
mysql>show databases;//可以查看有哪些数据库,返回数据库名(databaseName)
mysql>use databaseName;  //更换当前使用的数据库
mysql>show tables; //返回当前数据库下的所有表的名称
```
