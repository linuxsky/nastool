#!/bin/bash

# 定义颜色
green() {
	echo -e "\033[32m\033[01m$1\033[0m"
}
red() {
	echo -e "\033[31m\033[01m$1\033[0m"
}
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
# 检查wget是否安装
if which wget > /dev/null 2>&1; then
# 1.群晖、unraid等nas系统
nas() {
	bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/03_check_docker_compose.sh)
}
# 2.威联通系统
weiliantong() {
	wget -O check.sh https://gitee.com/juway111/nastool/raw/master/nas/03_check_docker_compose.sh && wget -O 00_nas_start.sh https://gitee.com/juway111/nastool/raw/master/nas/00_nas_start.sh && bash check.sh && rm -rf start.sh
}
# 3.centos服务器系统
centos() {
	bash <(curl -s https://gitee.com/juway111/nastool/raw/master/centos/00_centos_start.sh)
}
# 4.查看docker磁盘使用情况
df() {
	docker system df && docker system df -v
}
# 5.删除未被任何容器使用的本地卷
prune() {
	docker volume prune
}
# 6.删除未被任何容器使用的镜像（谨慎选择）
image() {
	docker image prune
}
#内存使用率
my_mem=$(free | awk '/^Mem:/{print $3/$2 * 100.0 "%"}')
#cpu平均使用率
my_cpu=$(top -bn1 | awk '/^%Cpu/{print $2+$4}')%
echo -e "
\033[33m=====================================================
$HOSTNAME你好！
请认准淘宝店铺：爱上nas爱上家
登录用户:$USER
所在目录:$PWD
内存使用率:$my_mem
CPU平均使用率:$my_cpu
====================================================="
green "
1.NAS系统：群晖、Unraid等
2.NAS系统：威联通等NAS
3.CentOS服务器

4.查看Docker磁盘使用情况
5.删除未被任何容器使用的本地卷
6.删除未被任何容器使用的镜像（谨慎选择）"
echo "0.清除缓存并退出脚本

======================================================"

read -p "请输入以上数字[0-6]查看系统相应信息: " num
if [  $num  == 1  ]; then
nas
elif [  $num  == 2  ]; then
weiliantong
elif [  $num  == 3  ]; then
centos
elif [  $num  == 4  ]; then
df
elif [  $num  == 5  ]; then
prune
elif [  $num  == 6  ]; then
image
elif [  $num  == 0  ]; then
red "我们下次再见，拜拜 "
rm -rf start.sh
exit 1
else
red "****请输入正确的数字，启动对应功能!****"
fi
else
	yum -y install wget
fi
bash <(curl -s https://gitee.com/juway111/nastool/raw/master/bash_start.sh)
bash start.sh