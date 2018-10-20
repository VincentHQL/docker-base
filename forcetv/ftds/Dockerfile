# 依赖基础镜像 docker_supervisor
FROM vincenthql/supervisor:latest

# 维护者信息
MAINTAINER VincentHQL <229323147@qq.com>


ADD container-files /

# PROCESS_START_NUMBER 进程起始
ENV \
  PROCESS_START_NUMBER=91 \
  PROCESS_COUNT=1 \
  NETBAND=500 \
  NETWORK_IP='127.0.0.1'



###############################################构建脚本####################################
# 构建image镜像
# docker build -t forcetv/ftds .

# docker run -it forcetv/ftds