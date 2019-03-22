---
title: Maven 配置阿里云中央仓库和自定义本地仓库
date: 2018-03-26 21:43:01
categories:
- 后端技术
tags:
- Maven
---

> 摘要：记录了Maven配置阿里云中央仓库和自定义本地仓库的流程。

<!-- more -->

## 问题描述
在国内访问 Maven 仓库的速度太慢，导致使用 IDEA 建立 Maven 项目会出现没有 src 目录结构的情况。

## 解决方案

### 中央仓库配置
在 Maven 安装目录下的 settings.xml 文件中的增加以下内容，使用阿里云的中央仓库。

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
在 Maven 安装目录下的 settings.xml 文件中设置本地仓库。

```
<localRepository>D:\myProgram\apache-maven-3.5.2\repositoryx</localRepository>
```
