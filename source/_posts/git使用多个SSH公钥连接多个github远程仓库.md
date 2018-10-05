---
title: git使用多个SSH公钥连接多个github远程仓库
date: 2018-09-12 16:31:37
categories:
- 通用技术
tags:
- git
---

> 摘要：默认情况下，单台机器只能使用一个与账户对应的SSH密钥连接github，这给多用户连接多账户带来不便。可利用config文件解决这一问题。

<!-- more -->

## 需求
机器A一直使用账户user1的SSH公钥连接github。现在新建账户user2，希望在机器A也能够以SSH方式连接到github

## 问题描述
默认情况下，即机器A一直使用账户user1。此时使用命令`$ git remote -v`可以查看当前的远程仓库关联如下：
```
origin  git@github.com:user1Name/repositorie1Name.git (fetch)
origin  git@github.com:user1Name/repositorie1Name.git (push)
```

如果user2新建一个名为repositorie2Name的仓库，此时想在机器A上使用命令`$ git push -u origin master`提交到远程仓库，会出现如下的错误。

```
ERROR: Permission to user2Name/repositorie2Name.git denied to user2.
fatal: Could not read from remote repository.Please make sure you have the correct access rights and the repository exists.
```

## 问题原因
机器A当前的公钥是user1的，user2没有权限使用；想在user2的账户中添加user1的公钥？也是不可能的，会提示公钥已经被使用。

## 解决方案
- 在user2的项目目录中打开命令行，执行命令：`ssh-keygen -t rsa -C "second@email.com" -f ~/.ssh/id_rsa_for_user2`，生成专属user2的密钥对，再进入user2的github账户将公钥配置完成。
- 在`~/.ssh/`目录下新建`config`文件，写入以下内容：

```
#Default GitHub
Host user1
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa

Host user2
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa_for_user2
```
- 回到命令行，执行命令：`$ git remote set-url origin user1:user1Name/repositorie1Name.git`，修改默认的关联。也可以把原有的默认关联删除，重新添加。
- 再继续执行命令：`$ git remote add origin2 user2:user2Name/repositorie2Name.git`，新添加一个user2的关联。
- 此时执行命令：`$ git remote -v`，应是以下结果：
```
origin2  user2:user2Name/repositorie2Name.git (fetch)
origin2  user2:user2Name/repositorie2Name.git (push)
origin  user1:user1Name/repositorie1Name.git (fetch)
origin  user1:user1Name/repositorie1Name.git (push)
```
- 验证。可分别执行命令：`$ ssh -T user1`、`$ ssh -T user2`，均出现连接成功提示，实现了多个SSH公钥连接多个github远程仓库的需求。
```
Hi user1! You've successfully authenticated, but GitHub does not provide shell access.
```
```
Hi user2! You've successfully authenticated, but GitHub does not provide shell access.
```
