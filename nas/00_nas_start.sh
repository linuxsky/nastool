#!/bin/bash
# 获取IP地址及其信息
# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1
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
# 1.查看本机ipv4公网IP
chaipv4() {
	myipv4=$(curl ifconfig.me)
echo "***************************************"
	yellow "$HOSTNAME你好,你的ipv4公网IP是:$myipv4"
echo "***************************************"
}
# 2.自动修改hosts文件
vi_hosts() {
# 判断 /etc/hosts 文件是否已经包含api.themoviedb.org，如果包含，则不会执行
if grep -q 'api.themoviedb.org' /etc/hosts; then
	yellow "文件已经包含 api.themoviedb.org，无需重复操作"
else
	read -p "输入 IP 地址1: " ip_address1
	read -p "输入 IP 地址2: " ip_address2
	echo -e "\n$ip_address1 api.themoviedb.org \n$ip_address2 api.themoviedb.org" >> /etc/hosts
fi
green "=================文件查看===================="
cat /etc/hosts && yellow "恭喜，hosts文件已修改完成!"
green "=================运行结束===================="
}
# 3.手动修改hosts文件
vi_etchosts() {
	vi /etc/hosts
}
# 4.自动安装nastool、TR、jellyfin、TMM
docker() {
	rm -rf 04_docker.sh && rm -rf 04_docker2.sh && wget -c https://nastool.work/bash/nas/04_docker.sh -O 04_docker.sh && wget -c https://nastool.work/bash/nas/04_docker2.sh -O 04_docker2.sh && bash 04_docker.sh
}
# 5.核显ls /dev/dri
hexian() {
	yellow "检查是否正确驱动核显。"
# 检查 ls /dev/dri 命令输入的文字是否一致
if [[ $(ls /dev/dri | grep "^renderD128$") == "renderD128" ]]; then
	ls /dev/dri&green "恭喜，本设备已经加载核显驱动。
虽然有核显驱动，但是解码能力取决于核显能力哦！"
else
	red "抱歉，本设备没有核显驱动。
建议您升级硬件或打驱动补丁哦！"
fi
}
# 6.下载ffmpeg  
ffmpeg() {
	bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/02_ffmpeg.sh)
}
# 99.删除所有docker容器和镜像
rm_images_container() {
	bash <(curl -s https://gitee.com/juway111/nastool/raw/master/99_rm_images_container.sh)
}
# 内存使用率
my_mem=$(free | awk '/^Mem:/{print $3/$2 * 100.0 "%"}')
# cpu平均使用率
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
 echo -e "\033[32m1.查看本机ipv4公网IP
2.添加api.themoviedb.org到hosts文件
3.手动编辑hosts文件
4.自动安装nastool、TR、jellyfin、TMM
5.检测本设备是否支持核显硬件解码
6.安装硬件解码FFmpeg\033[0m
\033[31m99.删除所有docker容器和镜像(谨慎选择)\033[0m
\033[32m0.返回首页\033[0m
======================================================"

read -p "请输入以上数字[0-6]查看系统相应信息: " num
if [  $num  == 1  ]; then
chaipv4
elif [  $num  == 2  ]; then
vi_hosts
elif [  $num  == 3  ]; then
vi_etchosts
elif [  $num  == 4  ]; then
docker
elif [  $num  == 5  ]; then
hexian
elif [  $num  == 6  ]; then
ffmpeg
elif [  $num  == 99  ]; then
rm_images_container
elif [  $num  == 0  ]; then
	red "我们下次再见，拜拜"
	exit 1
else
	red "请输入正确的数字，启动对应功能[0-6]: "
	yellow "请输入正确的数字，启动对应功能[0-6]: "
	green "请输入正确的数字，启动对应功能[0-6]: "
fi
	bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/00_nas_start.sh)
    bash 00_nas_start.sh