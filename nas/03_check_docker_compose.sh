#!/bin/bash  
  
# 定义颜色
yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}

# 获取 Docker Compose 的版本信息，输出将被存储在名为 result 的变量中
result=$(docker-compose --version)
  
# 检查result 的变量中是否包含"version"字符串
if ! [[ $result == *"version"* ]]; then    # 如果不包含"version"字符串，则安装docker-compose  
    yellow "正在安装 docker-compose..."
    mkdir -pv /usr/local/bin/ && chmod 777 /usr/local/bin/
    wget https://d.juway.top/d/nastool/Cloud%20Sync/1.Alist/wget/nastool/docker-compose-linux-x86_64.gz -O /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    docker-compose --version
if [ -f /usr/local/bin/docker-compose ]; then 
    yellow "安装成功！正在跳转..."
    rm -rf check.sh
    sleep 1
    bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/00_nas_start.sh)
    bash 00_nas_start.sh
else  
    yellow "安装失败，请重试！"
    exit 1
fi
else  
    yellow "docker-compose 已经安装！正在跳转..."  
    rm -rf check.sh
    sleep 1
    bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/00_nas_start.sh)
    bash 00_nas_start.sh
fi