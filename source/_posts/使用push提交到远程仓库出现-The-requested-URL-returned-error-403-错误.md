---
title: '使用push提交到远程仓库出现 The requested URL returned error: 403 错误'
date: 2018-09-12 14:31:16
categories:
- 通用技术
tags:
- git
---

> 摘要：使用push提交到远程仓库出现 The requested URL returned error: 403 错误的解决方法。

<!-- more -->

## 问题描述
- 电脑已经注册过一个github帐号，一直在本机使用，配置过SSH。
- 今天新建了一个github帐号，本地建立好项目之后，使用命令：`$ git push -u origin master`时出现以下错误
```
remote: Permission to userName/repositorieName.git denied to clxering.
fatal: unable to access 'https://github.com/userName/repositorieName.git/': The requested URL returned error: 403
```

## 问题原因
问题主要出在原注册账号上，系统保存了账号的信息。在使用新帐号时，信息不一致，所以报错。

## 解决
- 打开cmd，输入命令：`rundll32.exe keymgr.dll,KRShowKeyMgr`，出现存储的用户名和密码窗口
- 将github相关的条目删除
- 重新执行命令：`$ git push -u origin master`，提示输入账户名及密码后，成功。
```
Counting objects: 9, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (9/9), 716 bytes | 716.00 KiB/s, done.
Total 9 (delta 0), reused 6 (delta 0)
To https://github.com/userName/repositorieName.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```

## 原创性声明
- **本文为原创，转载请注明作者、出处及链接，谢谢。**