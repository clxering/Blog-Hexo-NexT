---
title: 修改 host 表开启 gist
date: 2019-03-30 08:33:40
categories:
- 通用技术
tags:
- git
---

> 摘要：通过修改系统 host 表来开启 gist

<!-- more -->

## 解决方案
以 win 10 系统为例，host 路径如下：

```
C:\Windows\System32\drivers\etc\hosts.ics
```

在文件末尾添加以下内容：

```
192.30.253.118 gist.github.com
192.30.253.119 gist.github.com
```
