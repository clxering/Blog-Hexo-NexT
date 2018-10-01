---
title: Spring中引入properties文件需要注意的细节
date: 2018-09-22 09:41:24
categories:
- 后端技术
tags:
- Spring
---

> 摘要：解决了在Spring中引入properties文件时，无法识别其中配置信息的问题。

<!-- more -->

## 问题描述

使用`<context:property-placeholder location="classpath:dataSource.properties"/>` 引入properties文件时，无法识别其中的配置信息。

- 注意：该标签在Spring配置文件中是唯一的

## 问题原因

增加属性system-properties-mode="FALLBACK"，即：`<context:property-placeholder location="classpath:dataSource.properties" system-properties-mode="FALLBACK"/>`，要求从本地读取properties。该属性默认取值为"ENVIRONMENT"，从系统环境中去读取，找不到文件时则报错。
