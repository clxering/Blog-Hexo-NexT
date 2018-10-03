---
title: MyBatis动态传入表名及字段名
date: 2018-10-02 09:11:31
categories:
- 后端技术
tags:
- MyBatis
---

> 摘要：记录当MyBatis需要动态传入表名及字段名时需要注意的细节和问题。

<!-- more -->

## 需求

原表数据量过大，进行水平分表后，要动态的传入表名执行查询。修改对应的mapper接口及映射文件，增加tableName字段，代码如下：

```
List<String> GetFundValueDataLimitByNum
(@Param("tableName") String tableName, @Param("fundCode") String fundCode, @Param("dataNum") Integer dataNum);
```

```
<select id="GetFundValueDataLimitByNum" parameterType="java.util.Map" resultType="java.lang.String">
        (SELECT cumulativeNAV,valueDate FROM #{tableName} WHERE fundCode=#{fundCode} ORDER BY valueDate DESC LIMIT #{dataNum})
        ORDER BY valueDate ASC
</select>
```

## 问题描述
上述代码及语句使用预编译方式，会出现运行时错误。

## 解决方案
修改`statementType`属性值为：`STATEMENT`，即采用非预编译。修改后的sql如下，mapper接口不变：

```
<select id="GetFundValueDataLimitByNum" parameterType="java.util.Map" resultType="java.lang.String" statementType="STATEMENT">
        (SELECT cumulativeNAV,valueDate FROM ${tableName} WHERE fundCode=${fundCode} ORDER BY valueDate DESC LIMIT ${dataNum})
        ORDER BY valueDate ASC
</select>
```

## 注意事项
- 使用非预编译时，传入的数据若为字符串，要添加引号，否则映射文件在形成sql语句时会出现错误
- 如果使用预编译，传入的数据若为字符串，不能加添加引号，会导致识别错误
- statementType属性取值有STATEMENT（非预编译），PREPARED（预编译）、CALLABLE，即Statement，PreparedStatement、CallableStatement模式，默认值为PREPARED
