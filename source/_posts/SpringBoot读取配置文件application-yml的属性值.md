---
title: SpringBoot 读取配置文件 application.yml 的属性值
date: 2019-04-23 21:30:26
categories:
tags:
---

> 摘要：记录 SpringBoot 读取配置文件 application.yml 的属性值的步骤和示例。

<!-- more -->

## 引入依赖
<!-- 支持 @ConfigurationProperties 注解 -->
```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-configuration-processor</artifactId>
    <optional>true</optional>
</dependency>
```

## 配置文件（application.yml）样例
```
myProps: #自定义的属性和值
 simpleProp: simplePropValue
 arrayProps: 1,2,3,4,5
 listProp1:
  - name: abc
   value: abcValue
  - name: efg
   value: efgValue 
 listProp2:
  - config2Value1
  - config2Vavlue2
 mapProps:
  key1: value1
  key2: value2
```

## 创建一个 bean 来接收配置信息
```
@Component
@ConfigurationProperties(prefix="myProps") //接收 myProps 下的属性
public class MyProps {
  private String simpleProp;
  private String[] arrayProps;
  private List<Map<String, String>> listProp1 = new ArrayList<>(); //接收prop1里面的属性值
  private List<String> listProp2 = new ArrayList<>(); //接收prop2里面的属性值
  private Map<String, String> mapProps = new HashMap<>(); //接收prop1里面的属性值

  public String getSimpleProp() {
    return simpleProp;
  }

  //String 类型的一定需要 setter 来接收属性值；maps、collections、arrays 则不需要
  public void setSimpleProp(String simpleProp) {
    this.simpleProp = simpleProp;
  }

  public List<Map<String, String>> getListProp1() {
    return listProp1;
  }
  public List<String> getListProp2() {
    return listProp2;
  }

  public String[] getArrayProps() {
    return arrayProps;
  }

  public void setArrayProps(String[] arrayProps) {
    this.arrayProps = arrayProps;
  }

  public Map<String, String> getMapProps() {
    return mapProps;
  }

  public void setMapProps(Map<String, String> mapProps) {
    this.mapProps = mapProps;
  }
}
```
启动后，这个bean里面的属性就会自动接收配置的值了。

## 测试
```
@Autowired
private MyProps myProps;  

@Test
public void propsTest() throws JsonProcessingException {
    System.out.println("simpleProp: " + myProps.getSimpleProp());
    System.out.println("arrayProps: " + objectMapper.writeValueAsString(myProps.getArrayProps()));
    System.out.println("listProp1: " + objectMapper.writeValueAsString(myProps.getListProp1()));
    System.out.println("listProp2: " + objectMapper.writeValueAsString(myProps.getListProp2()));
    System.out.println("mapProps: " + objectMapper.writeValueAsString(myProps.getMapProps()));
}
```
测试结果：
```
simpleProp: simplePropValue
arrayProps: ["1","2","3","4","5"]
listProp1: [{"name":"abc","value":"abcValue"},{"name":"efg","value":"efgValue"}]
listProp2: ["config2Value1","config2Vavlue2"]
mapProps: {"key1":"value1","key2":"value2"}
```
