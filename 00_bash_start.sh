#!/bin/bash
# 获取IP地址及其信息
# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1
#定义颜色
green() {
	echo -e "\033[32m\033[01m$1\033[0m"
}
red() {
	echo -e "\033[31m\033[01m$1\033[0m"
}
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}

if which wget > /dev/null 2>&1 
then
# 1.群晖、威联通、unraid等nas系统
nas() {
    bash <(curl https://gitee.com/juway111/nastool/raw/master/nas/00_nas_start.sh)
}
# 2.centos服务器系统
centos() {
    bash <(curl https://gitee.com/juway111/nastool/raw/master/centos/00_centos_start.sh)
}
# 3.查看docker整体磁盘使用率
docker system df() {
    docker system df
}
# 4.删除未被任何容器使用的本地卷
docker volume prune() {
    docker volume prune
}

#内存使用率
my_mem=$(free | awk '/^Mem:/{print $3/$2 * 100.0 "%"}')
#cpu平均使用率
my_cpu=$(top -bn1 | awk '/^%Cpu/{print $2+$4}')%
echo -e "
=====================================================
\033[33m$HOSTNAME你好！
请认准闲鱼号：爱上nas爱上家
登录用户:$USER
所在目录:$PWD
内存使用率:$my_mem
CPU平均使用率:$my_cpu
====================================================="
echo -e "\033[32m1.群晖、威联通、unraid等nas系统
2.centos服务器系统.
3.查看docker整体磁盘使用率
4.删除未被任何容器使用的本地卷
\033[32m0.退出脚本\033[0m
======================================================"

read -p  " 请输入以上数字[0-4]查看系统相应信息: " num
if [  $num  == 1  ]; then
nas
elif [  $num  == 2  ]; then
centos
elif [  $num  == 3  ]; then
docker system df
elif [  $num  == 4  ]; then
docker volume prune
elif [  $num  == 0  ]; then
red " 我们下次再见，拜拜"
exit
else
red "请输入正确的数字，启动对应功能[0-4]: "
yellow "请输入正确的数字，启动对应功能[0-4]: "
green "请输入正确的数字，启动对应功能[0-4]: "
bash <(curl https://gitee.com/juway111/nastool/raw/master/00_bash_start.sh)
fi
else
  yum -y install wget
fi