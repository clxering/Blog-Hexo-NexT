---
title: Maven配置阿里云中央仓库和自定义本地仓库
date: 2018-03-26 21:43:01
categories:
- 后端技术
tags:
- Maven
---

> 摘要：记录了Maven配置阿里云中央仓库和自定义本地仓库的流程。

<!-- more -->

## 问题描述
在国内访问Maven仓库的速度太慢，导致使用IDEA建立Maven项目会出现没有src目录结构的情况。

## 解决方案

### 中央仓库配置
在Maven安装目录下，settings.xml文件中的增加以下内容，使用阿里云的中央仓库。
```
<mirrors>
	<mirror>  
          <id>alimaven</id>  
          <mirrorOf>central</mirrorOf>  
          <name>aliyun maven</name>  
          <url>http://maven.aliyun.com/nexus/content/repositories/central/</url>  
    </mirror>  
</mirrors>
```

### 自定义本地仓库配置
在Maven安装目录下，settings.xml文件中设置本地仓库
```
<localRepository>D:\myProgram\apache-maven-3.5.2\repositoryx</localRepository>
```
