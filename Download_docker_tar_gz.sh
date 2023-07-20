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
# 读取输入的目录和需要挂载的容器名
read -p "请输入存储空间docker目录: " ip_address1
# 确认目录是否正确
green "==================================================="
echo -e "你输入的下载目录为: \033[33m$ip_address1/$ip_address2\033[0m"
yellow "请确认目录是否正确，会在你输入的目录下新建dockerdown文件夹"
read -p "若目录正确，请按 Y 继续，按 N 重试 ：" y

rm -rf $ip_address1/dockerdown && mkdir $ip_address1/dockerdown
# 下载文件
if [ $y = "y" ];then
    rm -rf $ip_address1/docker.tar.gz && wget -c https://d.juway.top/d/nastool/Cloud%20Sync/1.Alist/wget/nastool/docker.tar.gz -O $ip_address1/docker.tar.gz
# 检测是否下载
if [ -f $ip_address1/docker.tar.gz ]; then
    yellow "下载已完成！"
else
    yellow "下载失败，终止任务！"
    exit 1
fi
# 解压缩文件到docker目录
tar -zxf $ip_address1/docker.tar.gz -C $ip_address1/dockerdown
# 输出解压缩成功的提示
if [ -d "$ip_address1/dockerdown/nastool" ]; then
    yellow "解压缩成功，文件已经存储/dockerdown目录中"
    rm -rf $ip_address1/docker.tar.gz
    yellow "已下载，已清除缓存..."
    else
    rm -rf $ip_address1/docker.tar.gz
    yellow "解压失败，终止任务！"
    exit 1
fi
elif [ $y = "n" ];then
  red "目录设置错误，请重新设置！"
  bash <(curl https://gitee.com/juway111/nastool/raw/master/02_tar_docker.sh)
else
    echo "输入非法指令"
fi