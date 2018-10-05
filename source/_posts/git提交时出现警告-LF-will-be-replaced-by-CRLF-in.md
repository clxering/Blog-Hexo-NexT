---
title: git提交时出现警告LF-will-be-replaced-by-CRLF-in
date: 2018-10-02 16:10:42
categories:
- 通用技术
tags:
- git
---

> 摘要：记录了使用命令行提交时出现warning: LF will be replaced by CRLF的解决方案。

<!-- more -->

## 问题描述
提交时出现警告：`warning: LF will be replaced by CRLF `，但是不影响提交。

## 解决方案
- 配置选项修改，把core.autocrlf设置成false。其他选项如下：
  - git config --global core.autocrlf true #默认值
  - git config --global core.autocrlf input #从库中迁出代码不转换
  - git config --global core.autocrlf false  #不转换
