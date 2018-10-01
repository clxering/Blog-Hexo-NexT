---
title: 常用git命令
date: 2018-09-17 18:31:20
categories:
- 通用技术
tags:
- git
---

> 摘要：记录常用的git命令及使用场景。

<!-- more -->

⭐ 初始化git仓库
```
$ git init
```

⭐ 用户信息设置
```
使用--global参数可全局配置用户名和邮箱
$ git config --global user.name "Your Name"
$ git config --global user.email email@example.com
也可以对某个仓库指定不同的用户名和Email地址。
$ git config user.name "Your Name"
$ git config user.email email@example.com
```

⭐ 查看用户信息
```
$ git config user.name
$ git config user.email
```

⭐ 为git@example.com用户生成SSH公钥id_rsa文件并保存在默认目录~/.ssh下
```
$ ssh-keygen -t rsa -C "git@example.com " -f ~/.ssh/id_rsa
```

⭐ 测试username（默认用户名为git）的SSH链接是否正常
```
$ ssh –T <username>
```

⭐ 将修改的文件提交到暂存区，可反复多次使用，添加多个文件
```
$ git add <filename.xxx>
相关命令：
（1）提交被修改(modified)和被删除(deleted)文件，不包括新文件(new)
$ git add -u  
（2）提交新文件(new)和被修改(modified)文件，不包括被删除(deleted)文件
$ git add .  
（3）提交所有变化，包括上述（1）和（2）的功能
$ git add -A
```

⭐ 将文件提交到版本库
```
$ git commit -m "create new file"
```

⭐ 查看当前状态
```
可以查看是否存在变更，但不能查看具体变更了什么内容
$ git status
```

⭐ 查看文件具体变更内容
```
git diff <fileName.xxx>
```

⭐ 查看提交的历史版本
```
$ git log
使用参数--pretty=oneline，仅显示版本号。
$ git log --pretty=oneline
注：只能显示head指向的当前版本和之前的版本信息
```

⭐ 查看操作命令历史记录
```
$ git reflog
注：使用该命令可以某版本在执行回退后再次返回某版本，前提是不退出当前命令行窗口
```

⭐ 版本回退
```
回退到上一个版本
$ git reset --hard HEAD^
回退到上上一个版本
$ git reset --hard HEAD^^
回退到上50个版本
$ git reset --hard HEAD~50
根据版本号回退，版本号不必输入完全，可区别即可
$ git reset --hard <versionCode>
```

⭐ 撤销修改
```
修改后还没有被放到暂存区
git checkout -- <fileName.xxx>
修改后已经放到暂存区
$ git reset HEAD <fileName.xxx>
修改后已经提交到版本库
此时，使用版本回退，回退到指定版本
```

⭐ 删除文件
```
从暂存区删除文件
$ git rm <fileName.xxx>
从暂存区恢复文件，只能恢复文件到最新版本，并丢失最近一次提交后修改的内容。
$ git checkout -- <fileName.xxx>
```

⭐ 关联远程仓库
```
$ git remote add origin git@github.com:username/name.git
```

⭐ 查看全部关联的详细信息
```
$ git remote -v
```

⭐ 把本地库的所有内容推送到远程库
```
参数-u把本地的master分支和远程的master分支关联，简化提交远程库流程
$ git push -u origin master
使用参数-u关联后，推送最新修改
$ git push
```

⭐ 从远程仓库克隆
```
$ git clone git@github.com:username/name.git
Git支持多种协议，包括https，但通过ssh支持的原生git协议速度最快
```

⭐ 创建分支
```
（1）创建本地分支
$ git branch feature-local
切换到本地分支
$ git checkout feature-local
或创建并同时切换到本地分支
$ git checkout –b feature-local
（2）创建远程分支，有两种实现
1、在远程开好分支feature-branch，本地直接拉下来
git checkout -b feature-local origin/feature-branch
2、本地开好分支,推送到远程
$  git checkout -b feature-local
推送本地的feature-local分支到远程origin的feature-branch分支，若远程不存在该分支则新建。
$  git push origin feature-local:feature-branch
```

⭐ 查看所有分支
```
$ git branch
```

⭐ 合并分支
```
要合并dev分支到master主分支。先切换到master分支后，执行命令，
$ git merge dev
注：通常合并分支时Git会用Fast forward模式，但这种模式下，删除分支后，会丢掉分支信息。如果要强制禁用Fast forward模式，Git就会在merge时生成一个新的commit，这样，从分支历史上就可以看出分支信息。
$ git merge --no-ff -m "merge with no-ff" dev
使用git log查看分支历史
$ git log --graph --pretty=oneline --abbrev-commit
```

⭐ 删除分支
```
$ git branch -d <branchName>
如果分支还没有合并，使用上条命令会出现提示阻止删除，此时需要强行删除
$ git branch -D <branchName>
```

⭐ 查看分支合并情况
```
$ git log --graph --pretty=oneline --abbrev-commit
或，仅显示前10条
$ git log --oneline -10
```

⭐ 创建远程仓库分支
```
$ git checkout -b dev origin/dev
```

⭐保存工作现场
```
$ git stash
注：要提交到暂存区才可以执行stash，可以执行多次stash
```

⭐查看已经保存工作现场
```
$ git stash list
```

⭐恢复工作现场
```
（1）使用git stash apply恢复
$ git stash apply stash@{0}
注：这种方式恢复后stash内容并不删除，需要用git stash drop来删除
$ git stash drop stash@{0}
（2）另一种方式是用git stash pop，恢复的同时把stash内容也删了
$ git stash pop stash@{0}
```

⭐ 抓取最新提交到本地
```
$ git pull
如果git pull提示no tracking information，则说明本地分支和远程分支的链接关系没有创建，用命令git branch --set-upstream-to <branch-name> origin/<branch-name>。
（1）抓取远程分支最新提交到本地分支
git pull origin 远端分支名:本地分支名
```

⭐ 标签
```
切换到需要打标签的分支上
$ git tag v1.0
```

⭐ 查看所有标签
```
$ git tag
```

⭐ 补标签
```
查看历史提交，找到需要补标签的id
$ git log --pretty=oneline --abbrev-commit
执行命令
$ git tag v0.9 <commitId>
也可以为标签添加说明，用-a指定标签名，-m指定说明文字
$ git tag -a v0.1 -m "version 0.1" <commitId>
注：标签不是按时间顺序列出，而是按字母排序的
```

⭐ 查看标签信息
```
$ git show <tagName>
```

⭐ 删除标签
```
（1）删除本地标签
$ git tag -d v0.1
（2）删除远程标签，要先删除本地标签，再push
$ git tag -d v0.9
$ git push origin :refs/tags/v0.9
```

⭐ 将标签推送到远程
```
$ git push origin v1.0
一次性推送全部尚未推送到远程的本地标签
$ git push origin –-tags
```

⭐ 删除git缓存
```
git rm -r --cached .
例如，当ignore文件更新时，如果不清空缓存，则不生效。
```

⭐合并远程分支到本地
```
在本地新建一个temp分支，并将远程origin仓库的master分支代码下载到本地temp分支
git fetch origin master:tmp
比较本地代码与刚刚从远程下载下来的代码的区别
git diff tmp
合并temp分支到本地的master分支
git merge tmp
如果不想保留temp分支 可以用这步删除
git branch -d temp
注意：若提交历史不同，无法合并，参见“合并两个不同提交历史的分支”。
```

⭐ 合并两个不同提交历史的分支
```
将远程仓库的更新获取到本地分支temp
git fetch origin master:temp
此时若直接合并，因为提交历史不同，出现fatal: refusing to merge unrelated histories错误，需要增加参数，强制合并即可。
git merge temp --allow-unrelated-histories
```
