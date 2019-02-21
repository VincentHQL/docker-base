#基础镜像来自：ubuntu
FROM ubuntu:16.04

# 维护者信息
LABEL VincentHQL <229323147@qq.com>

# Add supervisord conf, bootstrap.sh files
COPY container-files /

RUN \
  apt-get autoclean && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y \
                  curl \
                  wget \
                  iproute \
                  net-tools \
                  hostname \
                  cron \
                  software-properties-common \
                  inotify-tools \
                  rsync \
                  python-pip && \
  rm -rf /var/lib/apt/lists/* && \
  pip install supervisor

ENTRYPOINT ["/config/bootstrap.sh"]

###############################################构建脚本####################################
# 构建image镜像
# docker build --tag=vincenthql/supervisor .

# docker run -it vincenthql/supervisor
