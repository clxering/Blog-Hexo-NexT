---
title: 使用 javax.mail 时出现 java.lang.NoClassDefFoundError:com/sun/mail/util/MailLogger 异常
date: 2019-03-23 07:48:07
categories:
- 后端技术
tags:
- 综合
---

> 摘要：记录使用 javax.mail 时出现 java.lang.NoClassDefFoundError: com/sun/mail/util/MailLogger 异常的解决。

<!-- more -->

## 需求
使用 `javax.mail` 实现简易的 QQ 邮件发送功能。主要代码如下：

```
public static void main(String[] args) throws Exception {
        Properties properties = new Properties();
        // 连接协议
        properties.put("mail.transport.protocol", "smtp");
        // SMTP 服务器名，可以从 QQ 邮箱的帮助文档查到
        // 文档地址：https://service.mail.qq.com/cgi-bin/help?subtype=1&no=167&id=28
        properties.put("mail.smtp.host", "smtp.qq.com");
        // SMTP 服务器端口号，可以从 QQ 邮箱的帮助文档查到端口为 465 或 587
        properties.put("mail.smtp.port", 465);
        // 是否需要身份验证
        properties.put("mail.smtp.auth", "true");
        // 是否使用 ssl 安全连接
        properties.put("mail.smtp.ssl.enable", "true");
        // 是否输出控制台信息
        properties.put("mail.debug", "true");
        // 得到会话对象
        Session session = Session.getInstance(properties);
        // 获取邮件对象
        Message message = new MimeMessage(session);
        // 设置发件人邮箱地址
        message.setFrom(new InternetAddress("1079368866@qq.com"));
        // 设置收件人邮箱地址
        message.setRecipients(Message.RecipientType.TO, new InternetAddress[]{new InternetAddress("573690535@qq.com")});
        // 设置邮件标题
        message.setSubject("title");
        // 设置邮件内容
        message.setText("content!");
        // 得到传输对象
        Transport transport = session.getTransport();
        // 参数1：发件邮箱（xxxx@qq.com）
        // 参数2：QQ 邮箱开通的 SMTP 服务后的客户端授权码
        transport.connect("参数1", "参数2");
        // 发送邮件
        transport.sendMessage(message, message.getAllRecipients());
        // 关闭链接
        transport.close();
    }
```

## 问题描述
在 `Session.getInstance(properties);` 所在位置出现 `java.lang.NoClassDefFoundError: com/sun/mail/util/MailLogger` 异常

## 解决方案
1、摘自 [StackOverflow]([https://stackoverflow.com/questions/16807758/java-lang-noclassdeffounderror-com-sun-mail-util-maillogger-for-junit-test-case)：

com.sun.mail.util.MailLogger is part of JavaMail API. It is already included in EE environment (that's why you can use it on your live server), but it is not included in SE environment.

[Oracle docs](https://www.oracle.com/technetwork/java/javamail/index.html):
https://www.oracle.com/technetwork/java/javamail/index.html

The JavaMail API is available as an optional package for use with Java SE platform and is also included in the Java EE platform.

99% that you run your tests in SE environment which means what you have to bother about adding it manually to your classpath when running tests.

If you're using maven add the following dependency (you might want to change version):

```
<dependency>
      <groupId>com.sun.mail</groupId>
      <artifactId>javax.mail</artifactId>
      <version>1.6.2</version>
</dependency>
```
2、注意，`com.sun.mail` 和 `javax.mail` 都要使用最新版本的引用，新旧版本可能差异较大，混搭可能会出现方法不存在或冲突的情况。
```
<dependency>
      <groupId>javax.mail</groupId>
      <artifactId>javax.mail-api</artifactId>
      <version>1.6.2</version>
</dependency>
```
3、开启 QQ 邮箱的 SMTP 服务

![开启 QQ 邮箱的 SMTP 服务](https://upload-images.jianshu.io/upload_images/5492471-c0e4614d4ac74ec1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
