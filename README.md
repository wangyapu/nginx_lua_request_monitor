# nginx_lua_request_monitor
nginx请求各项指标的监控与统计

## 主要功能

监控请求数、流量、请求时间、4xx、5xx等。

## 配置

    http {
        include       mime.types;
        default_type  application/octet-stream;
    
        lua_shared_dict statistics_dict 50M;
        lua_package_path "your_path/nginx_lua_request_monitor/?.lua";
    
        sendfile        on;
        keepalive_timeout  65;
    
        server {
            listen       80;
            server_name  localhost;
    
            set $domain_monitor "site.test.xxx.com";
            log_by_lua_file "your_path/nginx_lua_request_monitor/reqstat.lua";
    
            location / {
                root   html;
                index  index.html index.htm;
            }
           
        }
    
        # 监控服务
        server {
            listen 6080;
            server_name localhost;
            location /nginx_status {
                content_by_lua_file "your_path/nginx_lua_request_monitor/status_api.lua";
            }
        }
    
    }

## 提供的接口

- curl -v "http://localhost:6080/nginx_status"


    Server Name key:test.xxx.com
    Request Count:12
    Request Time Sum:0
    Flow Sum:5446
    4xx Code Count:3
    5xx Code Count:0 

- curl -v "http://localhost:6080/nginx_status?domain=test.xxx.com"
- curl -v "http://localhost:6080/nginx_status?domain=test.xxx.com&type=reqc"
- curl -v "http://localhost:6080/nginx_status?domain=test.xxx.com&type=reqt"
- curl -v "http://localhost:6080/nginx_status?domain=test.xxx.com&type=flow"
- curl -v "http://localhost:6080/nginx_status?domain=test.xxx.com&type=4xx"
- curl -v "http://localhost:6080/nginx_status?domain=test.xxx.com&type=5xx"


## 扩展

如果有其他需求，比如监控location、upstream的监控，只需在相应配置的作用域块中加入变量即可，扩展很方便。