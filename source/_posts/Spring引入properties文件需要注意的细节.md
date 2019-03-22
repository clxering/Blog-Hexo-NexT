---
title: Spring 引入 properties 文件需要注意的细节
date: 2018-09-22 09:41:24
categories:
- 后端技术
tags:
- Spring
---

> 摘要：解决了在Spring中引入properties文件时，无法识别其中配置信息的问题。

<!-- more -->

## 问题描述

使用 `<context:property-placeholder location="classpath:dataSource.properties"/>` 引入 properties 文件时，无法识别其中的配置信息。

## 问题原因
`<context:property-placeholder location="classpath:dataSource.properties"/>` 中 system-properties-mode 属性默认取值为 "ENVIRONMENT"，即从系统环境中去读取 properties 文件，找不到文件则报错。

## 解决方案
增加属性 `system-properties-mode="FALLBACK"`，即：`<context:property-placeholder location="classpath:dataSource.properties" system-properties-mode="FALLBACK"/>`，要求从本地读取 properties。

## 注意事项
context 标签在 Spring 配置文件中是唯一的。
