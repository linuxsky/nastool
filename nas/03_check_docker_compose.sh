#!/bin/bash  
  
# 检查docker-compose是否已安装  
result=$(docker-compose -v)  
  
# 检查输出是否包含"docker-compose"字符串  
if ! [[ $result == *"docker-compose"* ]]; then    # 如果不包含"docker-compose"字符串，则安装docker-compose  
  echo "Installing docker-compose..."  
  sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
if [ -f /usr/local/bin/docker-compose ]; then 
  echo "安装成功！正在跳转..."
  sleep 1
  bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/00_nas_start.sh)
  bash 00_nas_start.sh
else  
  echo "安装失败，请重试！"
fi
else  
  echo "docker-compose 已经安装！正在跳转..."  
  sleep 1
  bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/00_nas_start.sh)
  bash 00_nas_start.sh
fi