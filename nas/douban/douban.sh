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

# 下载文件
rm -rf nas-tools-2.9.1.tar.gz && wget -c https://gitee.com/juway111/nastool/raw/master/nas/douban/nas-tools-2.9.1.tar.gz -O nas-tools-2.9.1.tar.gz
if [ -f nas-tools-2.9.1.tar.gz ]; then
    yellow "下载已完成！"
else
    yellow "下载失败，终止任务！"
    exit 1
fi
yellow "*************************************"
container_id=$(docker ps -aqf "name=01-nastools")
echo "容器ID: $container_id"
yellow "*************************************"
mkdir -p /douban/
tar -zxf nas-tools-2.9.1.tar.gz -C /douban/
docker cp -a /douban/nas-tools $container_id:/
if [ -d "/douban/nas-tools" ]; then
    yellow "恭喜natool豆瓣api已经修复，重启容器生效"
    rm -rf nas-tools-2.9.1.tar.gz
    else
    yellow "解压失败，终止任务！"
    exit 1
fi