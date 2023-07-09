#!/bin/bash
# 增加颜色
green() {
	echo -e "\033[32m\033[01m$1\033[0m"
}
red() {
	echo -e "\033[31m\033[01m$1\033[0m"
}
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
# 1.nastool
nastool() {
  yellow "正在安装01-nastool，请稍后..."
  docker-compose -p nastool -f docker-compose-nastool.yaml up -d
  bash 04_docker2.sh
}
# 2.tr
tr() {
  yellow "正在安装02-tr下载器，请稍后..."
  docker-compose -p tr -f docker-compose-tr.yaml up -d
  bash 04_docker2.sh
}
# 3.jellyfin
jellyfin() {
  yellow "正在安装03-jellyfin播放器，请稍后..."
  docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
  bash 04_docker2.sh
}
# 4.tmm
tmm() {
  yellow "正在安装04-tmm搜刮器，请稍后..."
  docker-compose -p tmm -f docker-compose-tmm.yaml up -d
  bash 04_docker2.sh
}
# 5.all
all() {
  yellow "正在安装01-nastool，请稍后..."
  docker-compose -p nastool -f docker-compose-nastool.yaml up -d
  yellow "正在安装03-jellyfin播放器，请稍后..."
  docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
  yellow "正在安装02-qb下载器，请稍后..."
  docker-compose -p qb -f docker-compose-qb.yaml up -d
  yellow "正在安装05-jackett资源池，请稍后..."
  docker-compose -p jackett -f docker-compose-jackett.yaml up -d
  yellow "正在安装04-tmm搜刮器，请稍后..."
  docker-compose -p tmm -f docker-compose-tmm.yaml up -d
  yellow "正在安装02-tr下载器，请稍后..."
  docker-compose -p tr -f docker-compose-tr.yaml up -d
  bash 04_docker2.sh
}
# 6.nastool3.0
nastool3() {
  yellow "正在安装01-nastool-3.0，请稍后..."
  docker-compose -p nastool3 -f docker-compose-nastool3.yaml up -d
  bash 04_docker2.sh
}
# 7.nastool3.0全部安装
nastool3_all() {
  yellow "正在安装01-nastool-3.0，请稍后..."
  docker-compose -p nastool3 -f docker-compose-nastool3.yaml up -d
  yellow "正在安装03-jellyfin播放器，请稍后..."
  docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
  yellow "正在安装02-qb下载器，请稍后..."
  docker-compose -p qb -f docker-compose-qb.yaml up -d
  yellow "正在安装04-tmm搜刮器，请稍后..."
  docker-compose -p tmm -f docker-compose-tmm.yaml up -d
  yellow "正在安装02-tr下载器，请稍后..."
  docker-compose -p tr -f docker-compose-tr.yaml up -d
  bash 04_docker2.sh
}
# 8.jackett
jackett() {
  yellow "正在安装05-jackett资源池，请稍后..."
  docker-compose -p jackett -f docker-compose-jackett.yaml up -d
  bash 04_docker2.sh
}

# 0.清除缓存
rm_sh() {
  rm -rf 04_docker.sh
  rm -rf 04_docker2.sh
  rm -rf docker-compose-nastool.yaml
  rm -rf docker-compose-tr.yaml
  rm -rf docker-compose-jellyfin.yaml
  rm -rf docker-compose-tmm.yaml
  rm -rf docker-compose-nastool3.yaml
  rm -rf docker-compose-qb.yaml
  rm -rf docker-compose-jackett.yaml
}

echo " ===================================================== "
green "
1.NasTool_v2.9版本
2.TR下载器
3.Jellyfin播放器
4.TMM搜刮器 "
yellow "5.全部安装Nastool_v2.9版本6款软件 "
green "6.NasTool_v3.0+版本 "
yellow "7.全部安装Nastool_v3.0+版本5款软件 "
green "8.jackett资源池 "
echo "0.清除缓存并返回上一层

======================================================"

read -p  " 请输入以上数字，安装对应容器: " num 
if [  $num  == 1  ] ; then
nastool
elif [  $num  == 2  ]; then
tr
elif [  $num  == 3  ]; then
jellyfin
elif [  $num  == 4  ]; then
tmm
elif [  $num  == 5  ]; then
all
elif [  $num  == 6  ]; then
nastool3
elif [  $num  == 7  ]; then
nastool3_all
elif [  $num  == 8  ]; then
jackett
elif [  $num  == 0  ]; then
red " 清除缓存中，请稍等..."
rm_sh
exit
# 序号输入错误，提示并循环
else
red "请输入正确的数字，安装对应容器" 
yellow "请输入正确的数字，安装对应容器 " 
green "请输入正确的数字，安装对应容器" 
bash 04_docker2.sh
fi