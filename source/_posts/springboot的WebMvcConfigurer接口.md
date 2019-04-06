---
title: springboot 的 WebMvcConfigurer 接口
date: 2019-04-06 14:51:37
categories:
- 后端技术
tags:
- Spring
---

> 摘要：记录 WebMvcConfigurer 接口的注意事项和一般用法。

<!-- more -->

## 概述

如果要自定义 Handler，Interceptor，ViewResolver，MessageConverter，在 Spring Boot 1.5 是重写 WebMvcConfigurerAdapter 类的方法来实现。2.0 版本后，该类已过时，标记为 `@Deprecated`。目前的做法是实现 WebMvcConfigurer 接口来达到上述目的。为叙述方便，假设以下各实现均在 WebMvcConfig 类中：
```
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    ....
}
```

### ⭐ 配置视图解析
```
@Override
public void configureViewResolvers(ViewResolverRegistry registry) {
    registry.jsp("/WEB-INF/jsp/", ".jsp");
    registry.enableContentNegotiation(new MappingJackson2JsonView());
}
```
这和 `application.properties` 的 `spring.mvc.view.prefix` 以及 `spring.mvc.view.suffix` 是相同的。如果在代码中配置了视图解析，就可以不需要在 `application.properties` 中配置。

例如，假设静态资源在 WEB-INF 目录下，配置如下：
```
@Override
public void addResourceHandlers(ResourceHandlerRegistry registry) {
    registry.addResourceHandler("/resource/**").addResourceLocations("/WEB-INF/static/");
}
```
当请求 `http://localhost:8083/resource/1.png` 时，会把 `/WEB-INF/static/1.png` 返回。


### ⭐ 自定义静态资源映射规则
```
@Override
public void addResourceHandlers(ResourceHandlerRegistry registry) {
    // 所有静态资源均在 classpath 下
    registry.addResourceHandler("/**").addResourceLocations("classpath:/");

    // 添加其他路径
    registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");

    registry.addResourceHandler("/swagger-resources/**").addResourceLocations("classpath:/META-INF/resources/swagger-resources/");

    registry.addResourceHandler("/swagger/**").addResourceLocations("classpath:/META-INF/resources/swagger*");

    registry.addResourceHandler("/v2/api-docs/**").addResourceLocations("classpath:/META-INF/resources/v2/api-docs/");
}
```

### ⭐ 自定义拦截器
继承 HandlerInterceptorAdapter 类，并重写四个方法，分别对应拦截器的状态：请求处理前、接收请求后渲染前、接收请求后渲染后、请求结束后。
```
public class ReqInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("Interceptor preHandler method is running !");
        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("Interceptor postHandler method is running !");
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("Interceptor afterCompletion method is running !");
        super.afterCompletion(request, response, handler, ex);
    }

    @Override
    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("Interceptor afterConcurrentHandlingStarted method is running !");
        super.afterConcurrentHandlingStarted(request, response, handler);
    }
}
```
覆盖 addInterceptors 方法，添加拦截条件为所有请求：
```
@Override
public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(new ReqInterceptor()).addPathPatterns("/**");
}
```
测试：
```
@Controller
@RequestMapping("/test")
public class LocaleController {

    @GetMapping("/run")
    @ResponseBody
    public String locale(){
        System.out.println("Controller is running !");
        return "ok";
    }
}
```
结果：
```
Interceptor preHandler method is running !
Controller is running !
Interceptor postHandler method is running !
Interceptor afterCompletion method is running !
```

### ⭐ 配置消息转换器
以 fastJson 为例：
```
@Override
public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
   // 定义一个 convert 转换消息的对象
   FastJsonHttpMessageConverter fastJsonHttpMessageConverter = new FastJsonHttpMessageConverter();
   // 添加 fastJson 的配置信息，如：是否要格式化返回的 json 数据
   FastJsonConfig fastJsonConfig = new FastJsonConfig();
   fastJsonConfig.setSerializerFeatures(SerializerFeature.PrettyFormat,
           SerializerFeature.WriteMapNullValue,
           SerializerFeature.WriteNullStringAsEmpty,
           SerializerFeature.DisableCircularReferenceDetect,
           SerializerFeature.WriteNullListAsEmpty,
           SerializerFeature.WriteDateUseDateFormat);
   // 处理中文乱码
   List<MediaType> fastMediaTypes = new ArrayList<>();
   fastMediaTypes.add(MediaType.APPLICATION_JSON_UTF8);
   // 在 convert 中添加配置信息
   fastJsonHttpMessageConverter.setSupportedMediaTypes(fastMediaTypes);
   fastJsonHttpMessageConverter.setFastJsonConfig(fastJsonConfig);
   // 将 convert 添加到 converters 当中
   converters.add(fastJsonHttpMessageConverter);
}
```

### ⭐ 跨域支持
```
@Override
public void addCorsMappings(CorsRegistry registry) {
    registry.addMapping("/**")
            .allowedOrigins("*")
            .allowCredentials(true)
            .allowedMethods("GET", "POST", "DELETE", "PUT")
            .maxAge(3600 * 24);
}
```

### ⭐ 添加类型转换器和格式化器
```
@Override
public void addFormatters(FormatterRegistry registry) {
    registry.addFormatterForFieldType(LocalDate.class, new USLocalDateFormatter());
}
```

内容协商配置
```
@Override
public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
    // 是否通过请求Url的扩展名来决定media type
    configurer.favorPathExtension(true)
            // 不检查Accept请求头
            .ignoreAcceptHeader(true)
            .parameterName("mediaType")
            // 设置默认的media yype
            .defaultContentType(MediaType.TEXT_HTML)
            // 请求以.html结尾的会被当成MediaType.TEXT_HTML
            .mediaType("html", MediaType.TEXT_HTML)
            // 请求以.json结尾的会被当成MediaType.APPLICATION_JSON
            .mediaType("json", MediaType.APPLICATION_JSON);
}
```
