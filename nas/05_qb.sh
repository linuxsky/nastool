#!/bin/bash
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
rm -rf docker-compose-qb.yaml
# 读取输入的目录和需要挂载的容器名  
read -p "请输入你的docker目录: " ip_address1
read -p "请输入你的video 目录: " ip_address2
mkdir $ip_address1/qbittorrent
echo "version: '2.1'
services:
  qbittorrent:
    image: johngong/qbittorrent:latest
    # ports:
    #  - 8989:8989
    volumes:
      - $ip_address1/qbittorrent:/config   # 冒号左边请修改为你想保存配置的路径
      - $ip_address2:/video # 映射数据目录
    environment:
      - UID=0
      - GID=0
      - UMASK=022 # 掩码权限，默认000，可以考虑设置为022
      - QB_WEBUI_PORT=8989
      - QB_EE_BIN=false
    restart: always
    network_mode: host # bridge
    hostname: 02-qbittorrent-8989
    container_name: 02-qbittorrent-8989" >> docker-compose-qb.yaml
yellow "docker目录为: $ip_address1"
yellow "video 目录为: $ip_address2"
read -p "请确认y/n:" y
if [ $y = "y" ];then
  docker-compose -p qb -f docker-compose-qb.yaml up -d
  rm -rf docker-compose-qb.yaml
  yellow "所有软件已全部执行完毕，请检查是否已经正确安装。如未安装请重试！"
  rm -rf ./04_docker2.sh
  rm -rf ./04_docker.sh
  rm -rf ./05_qb.sh
elif [ $y = "n" ];then
    bash <(curl https://wuzhuwei.work/upload/sh/nas/05_qb.sh)
else
    echo "输入非法指令"
fi