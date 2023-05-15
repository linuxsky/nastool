#!/bin/bash
# 获取IP地址及其信息
# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1
# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi

arch=$(arch)

IP4=$(curl -s4m8 https://ip.gs/json)
IP6=$(curl -s6m8 https://ip.gs/json)
WAN4=$(expr "$IP4" : '.*ip\":\"\([^"]*\).*')
WAN6=$(expr "$IP6" : '.*ip\":\"\([^"]*\).*')
COUNTRY4=$(expr "$IP4" : '.*country\":\"\([^"]*\).*')
COUNTRY6=$(expr "$IP6" : '.*country\":\"\([^"]*\).*')
ASNORG4=$(expr "$IP4" : '.*asn_org\":\"\([^"]*\).*')
ASNORG6=$(expr "$IP6" : '.*asn_org\":\"\([^"]*\).*')
# 判断IP地址状态
IP4="$WAN4 （$COUNTRY4 $ASNORG4）"
IP6="$WAN6 （$COUNTRY6 $ASNORG6）"
if [ -z $WAN4 ]; then
	IP4="当前VPS未检测到IPv4地址"
fi
if [ -z $WAN6 ]; then
	IP6="当前VPS未检测到IPv6地址"
fi
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
#1.安装wget,git,bash-completion,net-tools
installgongj() {
    yum -y install wget git bash-completion net-tools curl make
}
#2.查看本机ipv4公网IP
chaipv4() {
    myipv4=$(curl ifconfig.me)
echo "***************************************"
yellow "$HOSTNAME你好,你的ipv4公网IP是:$myipv4"
echo "***************************************"
}
#3.测网速
cewangsu() {
    yum -y install git && git clone https://github.com/sivel/speedtest-cli.git && cd ./speedtest-cli/ && ./speedtest.py && cd .. ; rm -rf ./speedtest-cli
}
#4.安装docker与docker-compose
installdocker() {
    bash <(curl https://gitee.com/juway111/nastool/raw/master/centos/centos7installdocker.sh)
}
#5.更改root用户密码为Aa123456，开放ssh远程访问
installssh() {
    bash <(curl https://gitee.com/juway111/nastool/raw/master/centos/centos7tossh.sh)
}
#6.检查/开启/关闭指定端口
portone() {
    bash <(curl https://gitee.com/juway111/nastool/raw/master/centos/portone.sh)
}
#7.关闭防火墙
fanghuoqiang() {
    bash <(curl https://gitee.com/juway111/nastool/raw/master/centos/07_fanghuoqiang.sh)
}
#99.删除所有docker容器和镜像
rm_images_container() {
    bash <(curl https://gitee.com/juway111/nastool/raw/master/99_rm_images_container.sh)
}

mylinux=$(cat /etc/redhat-release)
#内存使用率
my_mem=$(free | awk '/^Mem:/{print $3/$2 * 100.0 "%"}')
#cpu平均使用率
my_cpu=$(top -bn1 | awk '/^%Cpu/{print $2+$4}')%
echo -e "
 =====================================================
 \033[33m欢迎使用《运维工具脚本》
 当前系统:$mylinux
 登录用户:$USER
 所在目录:$PWD
 内存使用率:$my_mem
 CPU平均使用率:$my_cpu
 =====================================================" 
 echo -e "\033[32m1.安装wget,git,bash-completion,net-tools,curl,make
2.查看本机ipv4公网IP
3.测网速
4.安装docker与docker-compose
5.更改root用户密码为Aa123456，开放ssh远程访问
6.检查/开启/关闭指定端口
7.关闭防火墙，开启所有端口
99.删除所有docker容器和镜像
0.退出脚本\033[0m
======================================================"

rm -rf ./gongju.sh.*
rm -rf ./speedtest-cli
read -p  " 请输入以上数字[0-8]查看系统相应信息: " num 
if [  $num  == 1  ] ; then
installgongj
elif [  $num  == 2  ]; then
chaipv4
elif [  $num  == 3  ]; then
cewangsu
elif [  $num  == 4  ]; then
installdocker
elif [  $num  == 5 ]; then
installssh
elif [  $num  == 6 ]; then
portone
elif [  $num  == 7 ]; then
fanghuoqiang
elif [  $num  == 99 ]; then
rm_images_container
elif [  $num  == 0  ]; then
red " 我们下次再见，拜拜"
exit
else
red "请输入正确的数字，启动对应功能[0-8]: " 
yellow "请输入正确的数字，启动对应功能[0-8]: " 
green "请输入正确的数字，启动对应功能[0-8]: " 
fi
bash <(curl https://gitee.com/juway111/nastool/raw/master/centos/00_centos_start.sh)
