---
title: Spring中引入properties文件需要注意的细节
date: 2018-09-22 09:41:24
categories:
- 后端技术
tags:
- Spring
---

> 摘要：解决了再Spring中引入properties文件时，无法识别的问题。

<!-- more -->

## 问题描述

使用`<context:property-placeholder location="classpath:dataSource.properties"/>` 引入properties文件时，无法识别。

- 注意
  - 该标签在Spring配置文件中是唯一的

## 问题原因

增加属性system-properties-mode="FALLBACK"即可。该属性默认取值为"ENVIRONMENT"，从系统环境中去读取。

## 原创性声明
- **本文为原创，转载请注明作者、出处及链接，谢谢。**
