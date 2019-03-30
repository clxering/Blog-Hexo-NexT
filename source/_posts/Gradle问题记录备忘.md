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

## 一、安装
1. 下载
2. 解压
3. 配置系统变量 `%GRADLE_HOME%` 指向解压路径，配置 path 变量，添加 `%GRADLE_HOME%\bin`。
4. 测试，输入命令 `gradle -v` 提示版本说明配置成功。

> 环境变量也可以不配置，在 IDE 中（如 Idea）指定路径即可。

## 二、异常及报错的解决方案汇总
### ⭐ 本地仓库配置参考
```
repositories {
    mavenLocal()
    maven { url "http://maven.aliyun.com/nexus/content/groups/public/" }
    mavenCentral()
    jcenter()
}
```

### ⭐ 指定编译版本
可选，在 Idea 中可独立配置。
```
sourceCompatibility = 1.8
targetCompatibility = 1.8
```

### ⭐ 显示指定依赖版本
```
configurations.all {
    resolutionStrategy {
        force 'org.apache.tomcat.embed:tomcat-embed-core:8.5.39'
    }
}
```

### ⭐ 如果使用了中文注释，编译时报错
添加 withType，编译时用 UTF-8 处理。
```
tasks.withType(JavaCompile) {
    options.encoding = "UTF-8"
}
```
