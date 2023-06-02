#!/bin/bash  
  
# 检查docker-compose是否已安装  
result=$(docker-compose -v)  
# 检查输出是否包含版本信息  
if ! [[ $result == *"docker-compose version:"*" " ]]; then  
  # 如果不包含版本信息，则安装docker-compose  
  echo "Installing docker-compose..."  
else  
  echo "docker-compose already installed"  
fi