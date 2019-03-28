---
title: Gradle 问题记录备忘
date: 2019-03-28 20:55:39
categories:
- 通用技术
tags:
- Gradle
---

> 摘要：记录了 Gradle 使用过程中出现的问题及解决方案。

<!-- more -->

## 一、异常及报错的解决方案汇总
### ⭐ 显示指定依赖版本
```
configurations.all {
    resolutionStrategy {
        force 'org.apache.tomcat.embed:tomcat-embed-core:8.5.39'
    }
}
```
