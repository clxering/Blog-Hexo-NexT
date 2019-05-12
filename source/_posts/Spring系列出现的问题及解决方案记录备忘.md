---
title: Spring 系列出现的问题及解决方案记录备忘
date: 2019-03-28 20:30:52
categories:
- 后端技术
tags:
- Spring
---

> 摘要：记录了 Spring Boot 使用过程中出现的问题及解决方案。

<!-- more -->

## 一、Spring 系列通用记录
### ⭐ 注解 `@Resource` 和 `@Autowired` 区别对比

`@Resource` 和 `@Autowired` 可在 bean 注入时使用。`@Resource` 并不是 Spring 的注解，它的包是 `javax.annotation.Resource`，需要导入，但是 Spring 支持该注解的注入。

#### 共同点
两者都可以写在字段和 setter 方法上。两者如果都写在字段上，那么就不需要再写 setter 方法。

#### 不同点
- `@Autowired` 是 Spring 提供的注解，需要导入包 `org.springframework.beans.factory.annotation.Autowired`，默认按照类型注入。

```
public class TestServiceImpl {
    // 下面两种@Autowired只要使用一种即可
    @Autowired
    private UserDao userDao; // 用于字段上

    @Autowired
    public void setUserDao(UserDao userDao) { // 用于属性的方法上
        this.userDao = userDao;
    }
}
```

- @Autowired 注解是按照类型装配依赖对象，默认情况下它要求依赖对象必须存在，如果允许null值，可以设置它的required属性为false。如果我们想使用按照名称（byName）来装配，可以结合@Qualifier注解一起使用。如下：

```
public class TestServiceImpl {
    @Autowired
    @Qualifier("userDao")
    private UserDao userDao;
}
```

- @Resource 默认按照 ByName 自动注入，由 J2EE 提供，需要导入包 javax.annotation.Resource。@Resource 有两个重要的属性：name 和 type，而 Spring 将 @Resource 注解的 name 属性解析为 bean 的名字，而 type 属性则解析为 bean 的类型。所以，如果使用 name 属性，则使用 byName 的自动注入策略，而使用 type 属性时则使用 byType 自动注入策略。如果既不制定 name 也不制定 type 属性，这时将通过反射机制使用 byName 自动注入策略。

```
public class TestServiceImpl {
    // 下面两种@Resource只要使用一种即可
    @Resource(name="userDao")
    private UserDao userDao; // 用于字段上

    @Resource(name="userDao")
    public void setUserDao(UserDao userDao) { // 用于属性的setter方法上
        this.userDao = userDao;
    }
}
```

注：最好是将 @Resource 放在 setter 方法上，因为这样更符合面向对象的思想，通过 set、get 去操作属性，而不是直接去操作属性。

#### 1.3 @Resource 装配顺序
- 如果同时指定了 name 和 type，则从 Spring 上下文中找到唯一匹配的 bean 进行装配，找不到则抛出异常。
- 如果指定了 name，则从上下文中查找名称（id）匹配的 bean 进行装配，找不到则抛出异常。
- 如果指定了 type，则从上下文中找到类似匹配的唯一 bean 进行装配，找不到或是找到多个，都会抛出异常。
- 如果既没有指定 name，又没有指定 type，则自动按照 byName 方式进行装配；如果没有匹配，则回退为一个原始类型进行匹配，如果匹配则自动装配。
- Resource 的作用相当于 @Autowired，只不过 @Autowired 按照 byType 自动注入。

### ⭐ @Autowired 注解的工作流程
#### 案例
定义了一个 BaseRepository  接口，其中定义了一个 printMyName 方法:
```
package defaultPackage.AutowiredTest;

public interface BaseRepository {
    String printMyName();
}
```

（2）定义一个 BaseRepository  接口的实现类，并实现 printMyName 方法，在这里指定了该 bean 在 IoC 中标识符名称为firstRepositoryImp
```
package defaultPackage.AutowiredTest;

import org.springframework.stereotype.Repository;

@Repository
public class FirstRepositoryImp implements BaseRepository {
    @Override
    public String printMyName() {
        return "My name is FirstRepositoryImp";
    }
}
```

（3）此时，一个 BaseRepository 类型的字段，需要通过 @Autowired 自动装配方式，从 IoC 容器中去查找到，并返回给该字段
```
package defaultPackage.AutowiredTest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserService {

    @Autowired
    private BaseRepository baseRepository;

    @RequestMapping("/getMyName")
    public String PrintName() {
        return baseRepository.printMyName();
    }
}
```
执行后输出 `My name is FirstRepositoryImp`

（4）以上代码的工作流程
在启动 Spring IoC 时，容器自动装载了一个 `AutowiredAnnotationBeanPostProcessor` 后置处理器，当容器扫描到 `@Autowied`、`@Resource` 或 `@Inject` 时，就会在 IoC 容器自动查找需要的 bean 并装配。

此时，再定义一个 SecondRepositoryImp 类来实现 BaseRepository 接口

```
package defaultPackage.AutowiredTest;

import org.springframework.stereotype.Repository;

@Repository
public class SecondRepositoryImp implements BaseRepository {
    @Override
    public String printMyName() {
        return "My name is SecondRepositoryImp";
    }
}
```

此时无法编译，报错 `Could not autowire. There is more than one bean of 'BaseRepository' type.` 因为在容器中有两个 BaseRepository 类型的实例，一个名称为 firstRepositoryImp，另一个为 secondRepositoryImp。

这里由于查询到有两个该类型的实例，那么应改用名称匹配方式，在容器中查找名称为 secondRepositoryImp 的实例，并自动装配。

```
@Autowired
private BaseRepository secondRepositoryImp;
```

但是修改名称的方式并不推荐，应使用 @Qualifier 注解，显式指定需要装配 bean 的名称，用法如下：

```
@Autowired
@Qualifier("secondRepositoryImp ")
private BaseRepository baseRepository;
```

输出结果 `My name is SecondRepositoryImp`

（5）注意事项
- 在使用 @Autowired 时，首先在容器中查询对应类型的 bean
- 如果查询结果刚好为一个，就将该 bean 装配给 @Autowired 指定的数据
- 如果查询的结果不止一个，那么 @Autowired 会根据名称来查找。
- 如果查询的结果为空，那么会抛出异常。解决方法时，使用 required=false

## 二、异常及报错的解决方案汇总
### ⭐ 数据库实体类使用 @Entity 注解提示 The type MultipartEntity is deprecated

#### 问题描述
这个情况是由于导入错了Entity包所导致的。@Entity 注解有两个引用来源 org.hibernate.annotations.Entity 和 javax.persistence.Entity，应该使用 javax.persistence.Entity。此时就不会出现过时的提示。

#### 区别和注意事项
JPA 的实体类和 Hibernate 的实体类都符合 Java 对象的 POJO 模型，具体定义如下：
（1）JPA 2.1 规范的实体类
- 实体类必须被明确声明，这可以使用 @javax.persistence.Entity 注解或者 XML 配置文件。
- 实体类必须是 top-level 的类。
- 为了支持运行时动态代理实现的延迟加载，实体类必须定义一个 public 或 protected 的无参数的构造函数，还可以有其他构造函数。
- 为了支持运行时动态代理实现的延迟加载，实体类不能是 final 的，其中的方法或实例变量都不能是 final 的。
- 如果实体类的对象可能会被远程调用，则实体类还必须实现 java.io.Serializable 接口。
- 实体类可以是抽象类。实体类可以继承非实体类和实体类，而非实体类也可以继承实体类。
- Enum 或接口不能被声明为 Entity。
- 实体类的持久化状态是通过实体类的实例变量表示的。实例变量只能通过实体类中的方法访问。

（2）Hibernate的实体类基本与 JPA 2.1 规范的实体类相似，只有如下区别
- Entity类必须定义一个非private(即可以是public、protected或默认)的无参数的构造函数，还可以有其他构造函数。
- Entity类不必是top-level的类。
- Entity类不必是final的，其中的方法或实例变量也不必是final的。但如果是final的，则无法利用代理的延迟加载功能。
- Entity类的实例变量可以被Entity类之外的其他方法访问
- Always import @javax.persistence.Entity

#### 其他
@org.hibernate.annotations.Entity是@javax.persistence.Entity的一个补充，但不是后者的替代品。如果想使用@org.hibernate.annotations.Entity所包含的特殊的功能的话，需要在添加@javax.persistence.Entity的基础上增加注释，如下：

```
@Entity   
@org.hibernate.annotations.Entity(optimisticLock=OptimisticLockType.ALL)   
public class MyEntity implements Serializable {   
}  
```

### ⭐ application.properties 配置文件
Spring Boot 中配置文件使用 application.properties 可能会有中文乱码的问题，使用 application.yml 可以避免这种情况。注意: yml 冒号后要有空格，否则会导致 yml 配置读取失效。

### ⭐ Application 启动类位置
Spring Boot 中要将 Application 启动类放在所有子包的外侧，而且不能直接放在 src 下，要再套一层包，让 Spring Boot 自动加载启动类所在包下及其子包下的所有组件。

### ⭐ Spring Boot 出现 Invalid character found in method name. HTTP method names must be tokens 异常

```
java.lang.IllegalArgumentException: Invalid character found in method name. HTTP method names must be tokens
	at org.apache.coyote.http11.Http11InputBuffer.parseRequestLine(Http11InputBuffer.java:428) ~[tomcat-embed-core-8.5.39.jar:8.5.39]
	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:684) ~[tomcat-embed-core-8.5.39.jar:8.5.39]
	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66) [tomcat-embed-core-8.5.39.jar:8.5.39]
	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:806) [tomcat-embed-core-8.5.39.jar:8.5.39]
	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1498) [tomcat-embed-core-8.5.39.jar:8.5.39]
	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49) [tomcat-embed-core-8.5.39.jar:8.5.39]
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [na:1.8.0_171]
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [na:1.8.0_171]
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61) [tomcat-embed-core-8.5.39.jar:8.5.39]
	at java.lang.Thread.run(Thread.java:748) [na:1.8.0_171]
```
解决方案：使用 https 方式请求导致，改为 http 即可。

### ⭐ Spring Boot 出现 missing ServletWebServerFactory bean 异常

```
Caused by: org.springframework.context.ApplicationContextException: Unable to start ServletWebServerApplicationContext due to missing ServletWebServerFactory bean.
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.getWebServerFactory(ServletWebServerApplicationContext.java:206) ~[spring-boot-2.1.3.RELEASE.jar:2.1.3.RELEASE]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.createWebServer(ServletWebServerApplicationContext.java:180) ~[spring-boot-2.1.3.RELEASE.jar:2.1.3.RELEASE]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.onRefresh(ServletWebServerApplicationContext.java:154) ~[spring-boot-2.1.3.RELEASE.jar:2.1.3.RELEASE]
	... 8 common frames omitted
```
解决方案：添加 tomcat-embed-core 即可
```
// https://mvnrepository.com/artifact/org.apache.tomcat.embed/tomcat-embed-core
    compile group: 'org.apache.tomcat.embed', name: 'tomcat-embed-core', version: '8.5.39'
```
如果引入有 `spring-boot-starter-web` 依赖，其中会包含最新版的 tomcat 版本，会覆盖单独引入的 tomcat 依赖。

### ⭐ spring-boot-starter-parent 依赖
`spring-boot-starter-parent` 是 maven 独有的，Maven 用户可以通过继承 `spring-boot-starter-parent` 项目来获得一些合理的默认配置。如果使用 Gradle，则不需要该依赖。

### ⭐ SpringBoot 命令行修改默认配置
- 修改默认端口：`java -jar test.jar --server.port=9090`
- 收集日志：`java -jar test.jar > user.log &`
- 后台启动命令（linux）：`nohup java -jar test.jar &`
- 执行启动环境：`java -jar test.jar  --spring.profiles.active=dev`
- 指定运行内存：`java -Xms1024m -Xmx1024m -jar test.jar`
可综合以上命令：`nohup java -jar -Xms1024m -Xmx1024m -jar test.jar --spring.profiles.active=dev &`

### ⭐ 引入 MySql 8.0.15 时出现异常
Cause: org.springframework.jdbc.CannotGetJdbcConnectionException: Could not get JDBC Connection; nested exception is java.sql.SQLException: The server time zone value '?й???????' is unrecognized or represents more than one time zone. You must configure either the server or JDBC driver (via the serverTimezone configuration property) to use a more specifc time zone value if you want to utilize time zone support.

在连接字符串后面加上?serverTimezone=UTC

其中UTC是统一标准世界时间。

完整的连接字符串示例：jdbc:mysql://localhost:3306/test?serverTimezone=UTC

或者还有另一种选择：jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&characterEncoding=UTF-8，这个是解决中文乱码输入问题，当然也可以和上面的一起结合：jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC

### ⭐ Spring 引入 properties 文件无法识别配置信息
1. 问题描述：使用 `<context:property-placeholder location="classpath:dataSource.properties"/>` 引入 properties 文件时，无法识别其中的配置信息。
2. 问题原因：`<context:property-placeholder location="classpath:dataSource.properties"/>` 中 system-properties-mode 属性默认取值为 "ENVIRONMENT"，即从系统环境中去读取 properties 文件，找不到文件则报错。
3. 解决方案：增加属性 `system-properties-mode="FALLBACK"`，即：`<context:property-placeholder location="classpath:dataSource.properties" system-properties-mode="FALLBACK"/>`，要求从本地读取 properties。
4. 注意事项：context 标签在 Spring 配置文件中是唯一的。

### ⭐ SpringBoot 不显示默认的网页标签页小图标
增加如下配置：
```
spring:
  mvc:
    favicon:
      enabled: false
```
再将自定义的 .ico 文件放置到 classpath 下（resources 文件夹）即可。

### ⭐ Spring 向静态成员进行依赖注入
以一个 service 为例子。如果希望通过 UserService 使用其中的静态方法，可以创建一个带 `@PostConstruct` 注解的 init() 方法即可，如下所示：
```
@Service
public class UserService {

    @Autowired
    private UserMapping userMapping;

    private static UserMapping userMappingStatic;

    @PostConstruct
    public void init() {
        userMappingStatic = this.userMapping;
    }

    public static List<Entity> getUserDataByID(int id) {
        return userMappingStatic.getUserDataByID(id);
    }

    public static void insertUserData(Entity entity) {
        userMappingStatic.insertUserData(entity);
    }
}
```
静态方法在 spring 是不推荐使用的。依赖注入的主要目的是让容器去产生一个对象的实例，然后在整个生命周期中使用他们，同时也让测试工作更加容易。一旦使用静态方法，就不再需要去产生这个类的实例，这会让测试变得更加困难，同时你也不能为一个给定的类依靠注入方式去产生多个具有不同的依赖环境的实例。这种 static 字段是隐含共享的，并且是一种全局状态，spring 同样不推荐使用。

### ⭐ Spring boot 配合 Mybatis 使用事务
## 项目结构
{% asset_img 1.png %}

## 主要演示代码
1、Application（添加 `@EnableTransactionManagement` 注解）
```
@SpringBootApplication
@EnableTransactionManagement
@MapperScan("defaultpackage.dao")
public class Application {

    public static void main(String[] args) {
        Logger log= LoggerFactory.getLogger(Application.class);
        SpringApplication.run(Application.class, args);
        log.info("测试开始！");
    }
}
```

2、Entity
```
public class Entity {

    private Integer id;
    private String name;
    private String age;

    ……省略 get、set 以及构造等内容
}
```

3、UserService（在需要事务的 service 方法添加 `@Transactional` 注解）
其中的 insertUserDataAuto 方法展示了事务特性。循环插入 5 条数据，当 index == 2 时报运行时错误，此时查看数据库，发现已经回滚，没有相关数据出现。
```
@Service
public class UserService {

    @Autowired
    private UserMapping userMapping;

    public List<Entity> getUserDataByID(int id) {
        return userMapping.getUserDataByID(id);
    }

    public void insertUserData(Entity entity) {
        userMapping.insertUserData(entity);
    }

    @Transactional
    public void insertUserDataAuto() {
        for (int index = 5; index > 0; index--) {
            if (index == 2) {
                throw new RuntimeException("this is a wrong!");
            }
            userMapping.insertUserData(new Entity("newApple", String.valueOf(index)));
        }
    }
}
```

4、Controller
```
@RestController
public class Controller {

    @Autowired
    private UserService userService;

    @RequestMapping("/find/{id}")
    public List<Entity> findElement(@PathVariable int id) {
        return userService.getUserDataByID(id);
    }

    @RequestMapping("/add/{name}/{age}")
    public Entity addElement(@PathVariable String name, @PathVariable String age) {
        Entity element = new Entity(name, age);
        userService.insertUserData(element);
        return element;
    }

    @RequestMapping("/add/run")
    public void addNElement() {
        userService.insertUserDataAuto();
    }
}
```

5、WebRunTest（仅为启动首页，与事务演示无关）
```
@Controller
public class WebRunTest {
    @RequestMapping("/")
    public String GotoIndexWeb() {
        return "index";
    }
}
```

6、UserMapping
```
@Repository
public interface UserMapping {
    List<Entity> getUserDataByID(int id);
    void insertUserData(Entity entity);
}
```

7、DataMapping.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="defaultpackage.dao.UserMapping">
    <select id="getUserDataByID" resultType="defaultpackage.domain.Entity">
        SELECT * FROM users WHERE id=#{id}
    </select>

    <insert id="insertUserData" parameterType="defaultpackage.domain.Entity">
        REPLACE into users (id, name, age) SELECT
        #{id}, #{name}, #{age}
        FROM DUAL
        WHERE NOT EXISTS(SELECT name, age FROM users WHERE name=#{name} AND age=#{age})
    </insert>
</mapper>
```

8、application.yml
```
spring:
  profiles:
    active: product
  datasource:
    url: jdbc:mysql://localhost:3306/datatest?useUnicode=true&characterEncoding=utf-8&useSSL=true&serverTimezone=UTC
    username: root
    password: 123456
  thymeleaf:
    prefix: classpath:/

server:
  port: 8089

mybatis:
  mapper-locations: classpath:mapper/*.xml
```

## 要点
- Application 添加 `@EnableTransactionManagement` 注解
- 在需要事务的 service 方法添加 `@Transactional` 注解
