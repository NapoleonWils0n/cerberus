#!/bin/bash

# nginx install
#==============

# install nginx - arch
#=====================

sudo pacman -S nginx

# To enable the Nginx service by default at start-up, run
sudo systemctl enable nginx

# start nginx - arch linux
sudo systemctl start nginx

# stop nginx - arch linux
sudo systemctl start nginx


# install nginx - ubuntu
#=======================

sudo apt-get install nginx


# start nginx - ubuntu 
sudo service nginx start

# stop nginx - ubuntu 
sudo service nginx stop

# restart nginx - ubuntu 
sudo service nginx restart


# edit nginx config file
sudo vim /etc/nginx/nginx.conf


user http http;

worker_processes 1;

events { worker_connections 1024; }

http {

    sendfile on;

    gzip              on;
    gzip_http_version 1.0;
    gzip_proxied      any;
    gzip_min_length   500;
    gzip_disable      "MSIE [1-6]\.";
    gzip_types        text/plain text/xml text/css
                      text/comma-separated-values
                      text/javascript
                      application/x-javascript
                      application/atom+xml;

    # List of application servers
    upstream app_servers {

        server 127.0.0.1:8080;

    }

    # Configuration for the server
    server {

        # Running port
        listen 80;

        # Proxying the connections connections
        location / {

            proxy_pass         http://app_servers;
            proxy_redirect     off;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host $server_name;

        }
    }
}
