# 依赖基础镜像 docker_supervisor
FROM vincenthql/supervisor:latest

# 维护者信息
MAINTAINER VincentHQL <229323147@qq.com>


RUN set -eux; \
  apt-get update; \
  apt-get install -y nginx; \
  # Rename nginx:nginx user/group to www:www, also set uid:gid to 80:80 (just to make it nice)
  groupmod --gid 80 --new-name www www-data; \
  usermod --uid 80 --home /data/www --gid 80 --login www --shell /bin/bash --comment www www-data; \
  # Clean-up /etc/nginx/ directory from all not needed stuff...
  rm -rf /etc/nginx/*.d /etc/nginx/*_params; \
  # Prepare dummy SSL certificates
  mkdir -p /etc/nginx/ssl; \
  openssl genrsa -out /etc/nginx/ssl/dummy.key 2048; \
  openssl req -new -key /etc/nginx/ssl/dummy.key -out /etc/nginx/ssl/dummy.csr -subj "/C=GB/L=London/O=Company Ltd/CN=docker"; \
  openssl x509 -req -days 3650 -in /etc/nginx/ssl/dummy.csr -signkey /etc/nginx/ssl/dummy.key -out /etc/nginx/ssl/dummy.crt; \
  apt-get clean

ADD container-files /

ENV \
  NGINX_GENERATE_DEFAULT_VHOST=false \
  STATUS_PAGE_ALLOWED_IP=127.0.0.1

EXPOSE 80 443


##########


# docker build -t global/docker-nginx .
# docker run -it global/docker-nginx