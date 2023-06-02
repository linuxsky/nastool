#!/bin/bash  
  
# 检查docker-compose是否已安装  
result=$(docker-compose -v)  
  
# 检查输出是否包含"docker-compose"字符串  
if ! [[ $result == *"docker-compose"* ]]; then  
  # 如果不包含"docker-compose"字符串，则安装docker-compose  
  echo "Installing docker-compose..."  
else  
  echo "docker-compose already installed"  
fi