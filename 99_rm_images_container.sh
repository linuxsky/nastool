#!/bin/sh  
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
echo "杀死所有正在运行的容器"  
docker kill $(docker ps -a -q)  
echo "删除所有已经停止的容器"  
docker rm -f $(docker ps -a -q)  
echo "删除所有镜像"  
docker rmi -f $(docker images -q)  
yellow "显示所有容器"  
docker ps -a  
yellow "显示所有镜像"  
docker images
yellow " ====================================================="  