---
title: Nginx 配置文件的结构详解及案例
date: 2018-10-05 15:09:08
categories:
- 后端技术
tags:
- Nginx
---

> 摘要：记录了Nginx的配置文件结构及具体条目的解析，同时例举了实际配置案例，如：宝塔Linux面板中Nginx 1.8的默认配置、http反向代理配置案例、https反向代理配置案例、负载均衡案例、多个webapp的配置案例、静态站点配置案例、跨域案例。最后，记录了upstream的几种配置方式。

<!-- more -->

## 相关链接

- nginx 源码：https://trac.nginx.org/nginx/browser
- nginx 官网：http://www.nginx.org/

## 配置文件结构

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

- 全局块：配置影响 nginx 全局的指令。一般有运行 nginx 服务器的用户组，nginx 进程 pid 存放路径，日志存放路径，配置文件引入，允许生成 worker process 数等。
- events 块：配置影响 nginx 服务器或与用户的网络连接。有每个进程的最大连接数，选取哪种事件驱动模型处理连接请求，是否允许同时接受多个网路连接，开启多个网络连接序列化等。
- http 块：配置代理，缓存，日志定义等绝大多数功能和第三方模块的配置。如文件引入，mime-type 定义，日志自定义，是否使用 sendfile 传输文件，连接超时时间，单连接请求数等。
- server 块：配置虚拟主机的相关参数，一个 http 中可以有多个 server。
- location 块：配置请求的路由，以及各种页面的处理情况。

## 配置文件细节

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
error_log log/error.log;
error_log log/error.log notice;
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

  #设定实际的服务器列表
  #这个模块通过一个简单的调度算法来实现客户端IP到后端服务器的负载均衡，upstream后接负载均衡器的名字，后端realserver以host:port options; 方式组织在 {} 中。如果后端被代理的只有一台，也可以直接写在
  upstream mysvr {   
    server 127.0.0.1:7878;
    #热备
    server 192.168.10.121:3333 backup;
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
        #反向代理的路径（和upstream绑定），location 后面设置映射的路径
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
          #过期30天，静态文件不怎么更新，过期可以设大一点，如果频繁更新，则可以设置得小一点。
          expires 30d;
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
      error_page   500 502 503 504  /50x.html;
      location = /50x.html {
          root   html;
      }
  }
}
```

## 宝塔Linux面板默认配置（Nginx 1.8）

```
user  www www;
worker_processes auto;
error_log  /www/wwwlogs/nginx_error.log  crit;
pid        /www/server/nginx/logs/nginx.pid;
worker_rlimit_nofile 51200;

events  {
        use epoll;
        worker_connections 51200;
        multi_accept on;
    }

http  {
        include       mime.types;
    		#include luawaf.conf;

    		include proxy.conf;

        default_type  application/octet-stream;

        server_names_hash_bucket_size 512;
        client_header_buffer_size 32k;
        large_client_header_buffers 4 32k;
        client_max_body_size 50m;

        sendfile   on;
        tcp_nopush on;

        keepalive_timeout 60;

        tcp_nodelay on;

        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
        fastcgi_buffer_size 64k;
        fastcgi_buffers 4 64k;
        fastcgi_busy_buffers_size 128k;
        fastcgi_temp_file_write_size 256k;
    		fastcgi_intercept_errors on;

        gzip on;
        gzip_min_length  1k;
        gzip_buffers     4 16k;
        gzip_http_version 1.1;
        gzip_comp_level 2;
        gzip_types     text/plain application/javascript application/x-javascript text/javascript text/css application/xml;
        gzip_vary on;
        gzip_proxied   expired no-cache no-store private auth;
        gzip_disable   "MSIE [1-6]\.";

        limit_conn_zone $binary_remote_addr zone=perip:10m;
    		limit_conn_zone $server_name zone=perserver:10m;

        server_tokens off;
        access_log off;

server  {
        listen 888;
        server_name www.bt.cn;
        index index.html index.htm index.php;
        root  /www/server/phpmyadmin;

        #error_page   404   /404.html;
        include enable-php.conf;

        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$
        {
            expires      30d;
        }

        location ~ .*\.(js|css)?$
        {
            expires      12h;
        }

        location ~ /\.
        {
            deny all;
        }

        access_log  /www/wwwlogs/access.log;
    }

include /www/server/panel/vhost/nginx/*.conf;
}
```

## http反向代理配置案例

```
#运行用户
#user www;

#启动进程,通常设置成和cpu的数量相等
worker_processes  1;

#全局错误日志
error_log  /www/server/logs/error.log;
error_log  /www/server/logs/notice.log  notice;
error_log  /www/server/logs/info.log  info;

#PID文件，记录当前启动的nginx的进程ID
pid        /www/server/logs/nginx.pid;

#工作模式及连接数上限
events {
    worker_connections 1024;    #单个后台worker process进程的最大并发链接数
}

#设定http服务器，利用它的反向代理功能提供负载均衡支持
http {
    #设定mime类型(邮件支持类型),类型由mime.types文件定义
    include       /www/server/conf/mime.types;
    default_type  application/octet-stream;

    #设定日志
    log_format  main  '[$remote_addr] - [$remote_user] [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log    /www/server/logs/access.log main;
    rewrite_log     on;

    #sendfile 指令指定 nginx 是否调用 sendfile 函数（zero copy 方式）来输出文件，对于普通应用，
    #必须设为 on,如果用来进行下载等应用磁盘IO重负载应用，可设置为 off，以平衡磁盘与网络I/O处理速度，降低系统的uptime.
    sendfile        on;
    #tcp_nopush     on;

    #连接超时时间
    keepalive_timeout  120;
    tcp_nodelay        on;

    #gzip压缩开关
    #gzip  on;

    #设定实际的服务器列表
    upstream server_list{
        server 127.0.0.1:8089;
    }

    #HTTP服务器
    server {
        listen  80;
        server_name  www.test.cn;
        index index.html
        root /www/server/test;

        #编码格式
        charset utf-8;

        #代理配置参数
        proxy_connect_timeout 180;
        proxy_send_timeout 180;
        proxy_read_timeout 180;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarder-For $remote_addr;

        #反向代理的路径
        location / {
            proxy_pass http://server_list;
        }

        #设置静态文件映射的路径
        location ~ ^/(images|javascript|js|css|flash|media|static)/ {
            root /www/server/views;
            #过期时限30天，若变动较少，可适当增加天数；反之减少。
            expires 30d;
        }

        #设定查看Nginx状态的地址
        location /NginxStatus {
            stub_status           on;
            access_log            on;
            auth_basic            "NginxStatus";
            auth_basic_user_file  conf/htpasswd;
        }

        #禁止访问.htxxx文件
        location ~ /\.ht {
            deny all;
        }

        #错误处理页面（可选）
        #error_page   404              /404.html;
        #error_page   500 502 503 504  /50x.html;
        #location = /50x.html {
        #    root   html;
        #}
    }
}
```

## https反向代理配置案例
安全性要求比较高的站点，可能会使用 HTTPS协议。HTTPS的固定端口号为443，使用SSL标准需要引入安全证书，所以在nginx.conf中需要指定证书和对应的key，其他设置和http反向代理一样，只是在Server部分配置有些不同。

```
#HTTP服务器
  server {
      #监听443端口
      listen  443 ssl;

      #定义www.test.cn
      server_name  www.test.cn;

      #ssl证书文件位置(常见证书文件格式为：crt/pem)
      ssl_certificate      cert.pem;
      #ssl证书key位置
      ssl_certificate_key  cert.key;

      #ssl配置参数（可选）
      ssl_session_cache    shared:SSL:1m;
      ssl_session_timeout  5m;

      #数字签名，此处使用MD5
      ssl_ciphers  HIGH:!aNULL:!MD5;
      ssl_prefer_server_ciphers  on;

      location / {
          root   /root;
          index  index.html index.htm;
      }
  }
```

## 负载均衡案例
有如下应用场景：
- 应用分别部署在`192.168.1.10:80`、`192.168.1.11:80`、`192.168.1.12:80`三台linux环境的服务器上。
- 网站域名为：`www.test.cn`，公网IP为`192.168.1.10`
- 在公网IP所在的服务器上部署nginx，对所有请求做负载均衡处理

```
http {
    #设定mime类型,类型由mime.type文件定义
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    #设定日志格式
    access_log    /var/log/nginx/access.log;

    #设定负载均衡的服务器列表
    upstream server_list {
        #weigth参数表示权值，权值越高被分配到的几率越大
        server 192.168.1.10:80   weight=1;
        server 192.168.1.11:80   weight=3;
        server 192.168.1.12:80   weight=7;
    }

   #HTTP服务器
   server {
        listen  80;
        server_name  www.test.cn;

        #对所有请求进行负载均衡请求
        location / {
            #定义服务器的默认网站根目录位置
            root        /root;
            #定义首页索引文件的名称
            index       index.html index.htm;
            #请求转向load_balance_server 定义的服务器列表
            proxy_pass  http://server_list;

            #其他反向代理的配置(可选)
            #proxy_redirect off;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            #后端的Web服务器可以通过X-Forwarded-For获取用户真实IP
            proxy_set_header X-Forwarded-For $remote_addr;
            proxy_connect_timeout 90;          #nginx跟后端服务器连接超时时间(代理连接超时)
            proxy_send_timeout 90;             #后端服务器数据回传时间(代理发送超时)
            proxy_read_timeout 90;             #连接成功后，后端服务器响应时间(代理接收超时)
            proxy_buffer_size 4k;              #设置代理服务器（nginx）保存用户头信息的缓冲区大小
            proxy_buffers 4 32k;               #proxy_buffers缓冲区，网页平均在32k以下的话，这样设置
            proxy_busy_buffers_size 64k;       #高负荷下缓冲大小（proxy_buffers*2）
            proxy_temp_file_write_size 64k;    #设定缓存文件夹大小，大于这个值，将从upstream服务器传

            client_max_body_size 10m;          #允许客户端请求的最大单文件字节数
            client_body_buffer_size 128k;      #缓冲区代理缓冲用户端请求的最大字节数
        }
    }
}
```

## 多个webapp的配置案例
将网站中一些功能相对独立的模块抽离出来，独立维护
- www.test.cn拆分出：A、B、C三个模块
- 访问上述模块的方式通过上下文(context)来进行区分:
  - www.test.cn/A/
  - www.test.cn/B/
  - www.test.cn/C/
- 这三个应用需要分别绑定不同的端口号。那么用户在实际访问站点时，访问不同模块时为了避免带端口号访问，需要用到反向代理。

```
http {
    upstream A_server{
        server www.test.cn:8081;
    }
    upstream B_server{
        server www.test.cn:8082;
    }
    upstream C_server{
        server www.test.cn:8083;
    }

    server {
        #默认指向A
        location / {
            proxy_pass http://A_server;
        }

        location /A/{
            proxy_pass http://A_server;
        }

        location /B/ {
            proxy_pass http://B_server;
        }

        location /C/ {
            proxy_pass http://C_server;
        }
    }
}
```

## 静态站点配置案例

网站静态资源都放在了/app/dist目录下，此时要在nginx.conf中指定首页以及这个站点的host即可。

```
worker_processes  1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    gzip on;
    gzip_types text/plain application/x-javascript text/css application/xml text/javascript application/javascript image/jpeg image/gif image/png;
    gzip_vary on;

    server {
        listen       80;
        server_name  static.zp.cn;

        location / {
            #转发任何请求到index.html
            index index.html;
            root /app/dist;
        }
    }
}
```

## 跨域案例

解决跨域问题一般有两种思路：
- jsonp。把后端根据请求，构造json数据并返回，前端用jsonp跨域。
- CORS。在后端服务器设置http响应头，把需要运行访问的域名加入加入Access-Control-Allow-Origin中。nginx 根据这个思路，提供了一种解决跨域的解决方案。举例：www.test.cn是由一个前端app，一个后端app组成的。前端端口号为9000，后端端口号为8080。前端和后端如果使用http进行交互时，请求会被拒绝，因为存在跨域问题。此时，在 enable-cors.conf 文件中设置 cors：

```
# allow origin list
set $ACAO '*';

# set single origin
if ($http_origin ~* (www.test.cn)$) {
  set $ACAO $http_origin;
}

if ($cors = "trueget") {
    add_header 'Access-Control-Allow-Origin' "$http_origin";
    add_header 'Access-Control-Allow-Credentials' 'true';
    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
}

if ($request_method = 'OPTIONS') {
  set $cors "${cors}options";
}

if ($request_method = 'GET') {
  set $cors "${cors}get";
}

if ($request_method = 'POST') {
  set $cors "${cors}post";
}
```

在服务器中include enable-cors.conf，即引入跨域配置：

```
# 可直接在 nginx config 中 include（推荐）
# www.test.cn域名需配合 dns hosts 进行配置
# 其中，api 开启了 cors，需配合本目录下另一份配置文件

upstream front_server{
  server www.test.cn:9000;
}

upstream api_server{
  server www.test.cn:8080;
}

server {
  listen       80;
  server_name  www.test.cn;

  location ~ ^/api/ {
    include enable-cors.conf;
    proxy_pass http://api_server;
    rewrite "^/api/(.*)$" /$1 break;
  }

  location ~ ^/ {
    proxy_pass http://front_server;
  }
}
```

## upstream的几种配置方式

第一种：轮询
```
upstream test{
server 192.168.0.1:3000;
server 192.168.0.1:3001;
}
```

第二种：权重
```
upstream test{
server 192.168.0.1 weight=2;
server 192.168.0.2 weight=3;
}
```
这种模式可解决服务器性能不等的情况下轮询比率的调配

第三种：ip_hash
```
upstream test{
ip_hash;
server 192.168.0.1;
server 192.168.0.2;
}
```
这种模式会根据来源IP和后端配置来做hash分配，确保固定IP只访问一个后端

第四种：fair
需要安装Upstream Fair Balancer Module
```
upstream test{
server 192.168.0.1;
server 192.168.0.2;
fair;
}
```
这种模式会根据后端服务的响应时间来分配，响应时间短的后端优先分配

第五种：自定义hash
需要安装Upstream Hash Module
```
upstream test{
server 192.168.0.1;
server 192.168.0.2;
hash $request_uri;
}
```
这种模式可以根据给定的字符串进行Hash分配

具体应用：

```
server{
  listen 80;
  server_name .test.com;
  charset utf-8;

  location / {
    proxy_pass http://test/;
  }
}
```

upstream每个地址可设置参数为：
- down: 表示此台server暂时不参与负载。
- weight: 默认为1，weight越大，负载的权重就越大。
- max_fails: 允许请求失败的次数默认为1.当超过最大次数时，返回proxy_next_upstream模块定义的错误。
- fail_timeout: max_fails次失败后，暂停的时间。
- backup: 其它所有的非backup机器down或者忙的时候，请求backup机器，应急措施。
