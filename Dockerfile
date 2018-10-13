#基础镜像来自：centos7
FROM centos:centos7

# 维护者信息
MAINTAINER VincentHQL <229323147@qq.com>


RUN \
  rpm --rebuilddb && yum clean all && \
  yum install -y epel-release && \
  yum update -y && \
  yum install -y \
                  iproute \
                  python-setuptools \
                  hostname \
                  inotify-tools \
                  yum-utils \
                  which \
                  jq \
                  rsync && \
  yum clean all && \
  easy_install supervisor

# Add supervisord conf, bootstrap.sh files
COPY container-files /

ENTRYPOINT ["/config/bootstrap.sh"]


###############################################构建脚本####################################
# 构建image镜像
# docker build --tag=global/docker-supervisor .

# docker run -it global/docker-supervisor
