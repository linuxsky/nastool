#!/bin/bash
# 增加颜色
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
#1.nastool
nastool() {
  yellow "正在安装01-nastool，请稍后..."
  docker-compose -p nastool -f docker-compose-nastool.yaml up -d
  bash ./04_docker2.sh
}
#2.tr
tr() {
  yellow "正在安装02-tr下载器，请稍后..."
  docker-compose -p tr -f docker-compose-tr.yaml up -d
  bash ./04_docker2.sh
}
#3.jellyfin
jellyfin() {
  yellow "正在安装03-jellyfin播放器，请稍后..."
  docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
  bash ./04_docker2.sh
}
#4.tmm
tmm() {
  yellow "正在安装04-tmm搜刮器，请稍后..."
  docker-compose -p tmm -f docker-compose-tmm.yaml up -d
  bash ./04_docker2.sh
}
#4.all
all() {
  yellow "正在安装01-nastool，请稍后..."
  docker-compose -p nastool -f docker-compose-nastool.yaml up -d
  yellow "正在安装02-tr下载器，请稍后..."
  docker-compose -p tr -f docker-compose-tr.yaml up -d
  yellow "正在安装03-jellyfin播放器，请稍后..."
  docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
  yellow "正在安装04-tmm搜刮器，请稍后..."
  docker-compose -p tmm -f docker-compose-tmm.yaml up -d
}
#6.清除缓存
rm_sh() {
  rm -rf ./04_docker.sh
  rm -rf ./04_docker2.sh
  rm -rf ./04_docker.sh
}
echo -e "\033[32m =====================================================
0.以下全部安装
1.nastool
2.tr下载器
3.jellyfin播放器
4.tmm
9.退出脚本\033[0m
======================================================"

read -p  " 请输入以上数字[0-4]安装相应容器: " num 
if [  $num  == 0  ]; then
all
elif [  $num  == 1  ] ; then
nastool
elif [  $num  == 2  ]; then
tr
elif [  $num  == 3  ]; then
jellyfin
elif [  $num  == 4  ]; then
tmm
elif [  $num  == 5  ]; then
qb
elif [  $num  == 9  ]; then
red " 我们下次再见，拜拜"
exit
else
red "请输入正确的数字，启动对应功能[0-4]: " 
yellow "请输入正确的数字，启动对应功能[0-4]: " 
green "请输入正确的数字，启动对应功能[0-4]: " 
fi