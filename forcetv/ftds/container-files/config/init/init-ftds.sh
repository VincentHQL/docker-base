#!/bin/bash

set -e
set -u

echo 'NETBAND  '$NETBAND
echo 'PROCESS_COUNT  '$PROCESS_COUNT
echo 'PROCESS_START_NUMBER  '$PROCESS_START_NUMBER
echo 'NETWORK_IP '$NETWORK_IP


# 修改supervisor.d配置
sed -i 's/PROCESS_START_NUMBER/'$PROCESS_START_NUMBER'/g' /data/conf/supervisor.d/ftds.conf
sed -i 's/PROCESS_COUNT/'$PROCESS_COUNT'/g' /data/conf/supervisor.d/ftds.conf
((FTDS_NETBAND=$NETBAND/$PROCESS_COUNT))
echo $FTDS_NETBAND

IPADDRESS=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | awk -F"/" '{print $1}')


for((i=$PROCESS_START_NUMBER; i<($PROCESS_START_NUMBER+$PROCESS_COUNT);i++));
do
    echo "Create Ftds Process $i"

    if [ ! -d '/data/conf/ftds' ];then
        mkdir -p '/data/conf/ftds'
    fi

    if [ -d "/data/workbench/ftds" ]; then
        mkdir -p '/data/workbench/ftds_3'$i
        cp /data/workbench/ftds/ftds3.8.1.3-2018-01-25 '/data/workbench/ftds_3'$i
    fi

    if [ -f "/data/workbench/ftds/ftds.ini" ];then
        if [ ! -f '/data/conf/ftds/ftds_3'$i'.ini' ];then
            cp /data/workbench/ftds/ftds.ini '/data/conf/ftds/ftds_3'$i'.ini'

             # 修改参数
            sed -i 's/SERVER_ID/3'$i'/g' '/data/conf/ftds/ftds_3'$i'.ini'
            sed -i 's/LOCAL_HOST/'$IPADDRESS'/' '/data/conf/ftds/ftds_3'$i'.ini'
            sed -i 's/NETWORK_IP/'$NETWORK_IP'/' '/data/conf/ftds/ftds_3'$i'.ini'
            sed -i 's/FTDS_NETBAND/'$FTDS_NETBAND'/' '/data/conf/ftds/ftds_3'$i'.ini'
            
            # ftds_conf=$(cat '/data/conf/ftds/ftds_3'$i'.ini')
            
        else
            echo '/data/conf/ftds/ftds_3'$i'.ini exist!'
        fi
    fi

    if [ ! -f '/data/workbench/ftds_3'$i'/ftds.ini' ];then
        ln -s '/data/conf/ftds/ftds_3'$i'.ini' '/data/workbench/ftds_3'$i'/ftds.ini'
    fi
    

    # 请求加密文件
    # html=$(curl --request POST \
    # --cookie 'PHPSESSID=iu2to51bsshk2upe006494d5h6; thinkphp_show_page_trace=0|0' \
    # --url 'http://59.56.96.124:8080/index.php?s=%2FAdmin%2FKaisa%2FEncrypt.html' \
    # --header 'cache-control: no-cache' \
    # --header 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
    # --form 'plaintext=$ftds_conf' \
    # --form name=string)
    
    # echo $html

    # awk 'BEGIN {FS="[<>]"; ORS="\t"} /(访问|积分|排名)：<tr>.*<\/tr>/ \
	# { if($3 == "访问：") {gsub(/[^0-9]+/, ""); print} \
	# else if($3 == "积分：") {gsub(/[^0-9]+/, ""); print} \
	# else if($3 == "排名：") {gsub(/[^0-9]+/, ""); print}}' blog

    # ln -s '/data/conf/ftds/ftds_encrypt_3'$i'.ini' '/data/workbench/ftds_3'$i'/ftds.ini'
done


if [ -d "/data/workbench/ftds" ]; then
    rm /data/workbench/ftds -Rf
else
    echo "not found ftds temple!"
fi
