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
# 1.输入密码可见后续步骤
password() {
	wget -O start.sh https://gitee.com/juway111/nastool/raw/master/01_start.sh && bash start.sh
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
CPU平均使用率:$my_cpu"
green "====================================================="

read -s -p "请输入访问密码: " num
if [  $num  == 20201019  ]; then
password
elif [  $num  == 0  ]; then
red "我们下次再见，拜拜 "
rm -rf start.sh
exit 1
else
red "****密码错误！请重新输入！****"
fi
else
	yum -y install wget
fi
bash <(curl -s https://gitee.com/juway111/nastool/raw/master/password.sh)
bash password.sh