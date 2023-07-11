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

read -p "请先确认版本，2.9请按数字“2”，3.2请按数字“3”：" y
if [ $y = "2" ];then
# 下载文件
    rm -rf nas-tools-2.9.1.tar.gz && wget -c https://gitee.com/juway111/nastool/raw/master/nas/douban/nas-tools-2.9.1.tar.gz -O nas-tools-2.9.1.tar.gz
if [ -f nas-tools-2.9.1.tar.gz ]; then
    yellow "下载已完成！"
else
    yellow "下载失败，终止任务！"
    exit 1
fi
yellow "请查看nastool的docker容器名称"
docker ps
read -p "请输入你的docker容器名称：" y2
rm -f /douban/ && mkdir /douban/
tar -zxf nas-tools-2.9.1.tar.gz -C /douban/
docker cp -a /douban/nas-tools $y2:/
if [ -d "$y2:/web" ]; then
    yellow "解压缩成功，文件已经存储docker目录中"
    rm -rf nas-tools-2.9.1.tar.gz
    else
    yellow "解压失败，终止任务！"
    exit 1
fi
fi