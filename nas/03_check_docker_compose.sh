#!/bin/bash  
  
# 定义颜色
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
# 检查docker-compose是否已安装  
result=$(docker-compose -v)  
  
# 检查输出是否包含"docker-compose"字符串  
if ! [[ $result == *"version"* ]]; then    # 如果不包含"version"字符串，则安装docker-compose  
  yellow "正在安装 docker-compose..."  
  wget https://d.nastool.work/d/%E9%98%BF%E9%87%8C%E4%BA%91%E7%9B%98/%E9%98%BF%E9%87%8C%E4%BA%91%E7%9B%98%E5%90%8C%E6%AD%A5/1.%E6%B8%B8%E5%AE%A2%E4%B8%8B%E8%BD%BD/SSH%E5%B7%A5%E5%85%B7/wget%E4%B8%8B%E8%BD%BD%E7%9B%AE%E5%BD%95/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
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