---
title: Nginx的结构及配置文件解析
date: 2018-09-23 15:09:08
categories:
- 通用技术
tags:
- nginx
---

> 摘要：本文记录了Nginx的结构及配置文件解析

<!-- more -->

## Nginx相关地址

源码：https://trac.nginx.org/nginx/browser

官网：http://www.nginx.org/

## Nginx配置文件结构

```
...              #全局块

events {         #events块
   ...
}

http      #http块
{
    ...   #http全局块
    server        #server块1
    {
        ...       #server全局块
        location [PATTERN]   #location块1
        {
            ...
        }
        location [PATTERN]   #location块2
        {
            ...
        }
    }
    server        #server块2
    {
      ...
    }
}
```

- 全局块：配置影响nginx全局的指令。一般有运行nginx服务器的用户组，nginx进程pid存放路径，日志存放路径，配置文件引入，允许生成worker process数等。
- events块：配置影响nginx服务器或与用户的网络连接。有每个进程的最大连接数，选取哪种事件驱动模型处理连接请求，是否允许同时接受多个网路连接，开启多个网络连接序列化等。
- http块：可以嵌套多个server，配置代理，缓存，日志定义等绝大多数功能和第三方模块的配置。如文件引入，mime-type定义，日志自定义，是否使用sendfile传输文件，连接超时时间，单连接请求数等。
- server块：配置虚拟主机的相关参数，一个http中可以有多个server。
- location块：配置请求的路由，以及各种页面的处理情况。

## Nginx配置文件细节

```
#配置用户或者组，默认为nobody nobody
user administrator administrators;

#允许生成的进程数，默认为1，也可以设置为auto，这个数值简单一点可以设置为cpu的核数grep ^processor /proc/cpuinfo | wc -l，也是auto值，如果开启了ssl和gzip更应该设置成与逻辑CPU数量一样甚至为2倍，可以减少I/O操作。如果nginx服务器还有其它服务，可以考虑适当减少。
worker_processes 2;

#默认是没有设置，可以限制为操作系统最大的限制65535。
worker_rlimit_nofile 10240

#指定nginx进程运行文件存放地址
pid /nginx/pid/nginx.pid;

#设置日志路径和级别。这个设置可以放入全局块，http块，server块，可选级别：debug|info|notice|warn|error|crit|alert|emerg
error_log log/error.log debug;

events {
  #设置网路连接序列化，防止惊群现象发生，默认为on，惊群现象：一个网路连接到来，多个睡眠的进程被同时叫醒，但只有一个进程能获得链接，这样会影响系统性能。
  accept_mutex on;

  #设置一个进程是否同时接受多个网络连接，默认为off
  multi_accept on;

  #事件驱动模型，可选：select|poll|kqueue|epoll|resig|/dev/poll|eventport，在Linux操作系统下，nginx默认使用epoll事件模型，得益于此，nginx在Linux操作系统下效率相当高。同时Nginx在OpenBSD或FreeBSD操作系统上采用类似于epoll的高效事件模型kqueue。在操作系统不支持这些高效模型时才使用select。
  use epoll;

  #最大连接数，默认为512，每一个worker进程能并发处理（发起）的最大连接数（包含与客户端或后端被代理服务器间等所有连接数）
  #nginx作为反向代理服务器，计算公式最大连接数 = worker_processes * worker_connections/4，所以这里客户端最大连接数是1024，这个可以增到到8192都没关系，看情况而定，但不能超过后面的worker_rlimit_nofile。当nginx作为http服务器时，计算公式里面是除以2。
  worker_connections  1024;
}

http {
  #文件扩展名与文件类型映射表
  include mime.types;

  #默认文件类型，默认为text/plain
  default_type  application/octet-stream;

  #取消服务日志
  #access_log off;

  #自定义格式
  log_format myFormat '$remote_addr–$remote_user [$time_local] $request $status $body_bytes_sent $http_referer $http_user_agent $http_x_forwarded_for';

  #自定义格式含义
  #$remote_addr与$http_x_forwarded_for，记录客户端的ip地址
  #$remote_user，记录客户端用户名称
  #$time_local，记录访问时间与时区
  #$request，记录请求的url与http协议
  #$status，记录请求状态；成功是200
  #$body_bytes_s ent，记录发送给客户端文件主体内容大小
  #$http_referer，记录从那个页面链接访问过来的
  #$http_user_agent，记录客户端浏览器的相关信息

  #combined为日志格式的默认值
  access_log log/access.log myFormat;

  #允许sendfile方式传输文件，默认为off，可以在http块，server块，location块，开启高效文件传输模式，sendfile指令指定nginx是否调用sendfile函数来输出文件，减少用户空间到内核空间的上下文切换。对于普通应用设为 on，如果用来进行下载等应用磁盘IO重负载应用，可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。
  sendfile on;

  #每个进程每次调用传输数量不能大于设定的值，默认为0，即不设上限
  sendfile_max_chunk 100k;

  #连接超时时间，默认为75s，可以在http，server，location块，长连接超时时间，单位是秒，这个参数很敏感，涉及浏览器的种类、后端服务器的超时设置、操作系统的设置。长连接请求大量小文件的时候，可以减少重建连接的开销，但假如有大文件上传，65s内没上传完成会导致失败。如果设置时间过长，用户又多，长时间保持连接会占用大量资源。
  keepalive_timeout 65;

  #http_proxy 设置
  #允许客户端请求的最大单文件字节数。如果有上传较大文件，请设置它的限制值
  client_max_body_size  10m;

  #缓冲区代理缓冲用户端请求的最大字节数
  client_body_buffer_size 128k;

  proxy_connect_timeout 75;
  proxy_send_timeout  75;
  proxy_read_timeout  75;
  proxy_buffer_size 4k;
  proxy_buffers 4 32k;
  proxy_busy_buffers_size 64k;
  proxy_temp_file_write_size  64k;
  proxy_temp_path   /usr/local/nginx/proxy_temp 1 2;

  #这个模块通过一个简单的调度算法来实现客户端IP到后端服务器的负载均衡，upstream后接负载均衡器的名字，后端realserver以host:port options; 方式组织在 {} 中。如果后端被代理的只有一台，也可以直接写在
  upstream mysvr {   
    server 127.0.0.1:7878;
    server 192.168.10.121:3333 backup;  #热备
  }

  #错误页，若该配置要生效，还需要配置proxy_intercept_errors
  error_page 404 https://www.baidu.com;

  server {
      #单连接请求上限次数
      keepalive_requests  120;
      #监听端口，默认80，小于1024的要以root启动。可以为listen *:80、listen 127.0.0.1:80等形式。
      listen  4545;
      #监听地址，可以通过正则匹配。  
      server_name 127.0.0.1;
      #请求的url过滤，正则匹配，~为区分大小写，~*为不区分大小写。
      location  ~*^.+$ {
        #根目录
        #root path;
        #设置默认页
        #index vv.txt;
        #请求转向mysvr 定义的服务器列表
        proxy_pass  http://mysvr;
        #拒绝的ip
        deny  127.0.0.1;
        #允许的ip
        allow 172.18.5.54;
      }
  }

  server {
      listen  80;
      server_name  itoatest.example.com;
      root   /apps/oaapp;
      charset utf-8;
      access_log  logs/host.access.log  main;
      #对/所有做负载均衡+反向代理
      location / {
          root   /apps/oaapp;
          index  index.jsp index.html index.htm;
          proxy_pass  http://backend;
          proxy_redirect off;
          # 后端的Web服务器可以通过X-Forwarded-For获取用户真实IP
          proxy_set_header  Host  $host;
          proxy_set_header  X-Real-IP  $remote_addr;
          proxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;
          proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
      }
      #静态文件，nginx自己处理，不去backend请求tomcat
      location  ~* /download/ {
          root /apps/oa/fs;
      }
      location ~ .*\.(gif|jpg|jpeg|bmp|png|ico|txt|js|css)$
      {   
          root /apps/oaapp;
          expires 7d;
      }
      location /nginx_status {
          stub_status on;
          access_log off;
          allow 192.168.10.0/24;
          deny all;
      }
      location ~ ^/(WEB-INF)/ {
          deny all;
      }
      #error_page  404  /404.html;
      # redirect server error pages to the static page /50x.html
      #
      error_page   500 502 503 504  /50x.html;
      location = /50x.html {
          root   html;
      }
  }
}
```

## 原创性声明
- **本文为原创，转载请注明作者、出处及链接，谢谢。**
