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

# 2.9版本---------------
2.9() {
# 下载文件
rm -rf nas-tools-2.9.1.tar.gz && wget -c https://gitee.com/juway111/nastool/raw/master/nas/douban/nas-tools-2.9.1.tar.gz -O nas-tools-2.9.1.tar.gz
if [ -f nas-tools-2.9.1.tar.gz ]; then
    yellow "下载已完成！"
else
    yellow "下载失败，终止任务！"
    exit 1
fi
yellow "请查看nastool的docker容器ID"
docker ps
yellow "*************************************"
read -p "请输入你的docker容器ID：" y2
mkdir -p /douban/
tar -zxf nas-tools-2.9.1.tar.gz -C /douban/
docker cp -a /douban/nas-tools $y2:/
if [ -d "/douban/nas-tools" ]; then
    yellow "恭喜natool豆瓣api已经修复，重启容器生效"
    rm -rf nas-tools-2.9.1.tar.gz
    else
    yellow "解压失败，终止任务！"
    exit 1
fi
}
# 3.2版本-----------
3.2() {
# 下载文件
rm -rf nas-tools-3.2.3.tar.gz && wget -c https://gitee.com/juway111/nastool/raw/master/nas/douban/nas-tools-3.2.3.tar.gz -O nas-tools-3.2.3.tar.gz
if [ -f nas-tools-3.2.3.tar.gz ]; then
    yellow "下载已完成！"
else
    yellow "下载失败，终止任务！"
    exit 1
fi
yellow "请查看nastool的docker容器ID"
docker ps
yellow "*************************************"
read -p "请输入你的docker容器ID：" y2
mkdir -p /douban/
tar -zxf nas-tools-3.2.3.tar.gz -C /douban/
docker cp -a /douban/nas-tools $y2:/
if [ -d "/douban/nas-tools" ]; then
    yellow "恭喜natool豆瓣api已经修复，重启容器生效"
    rm -rf nas-tools-3.2.3.tar.gz
    else
    yellow "解压失败，终止任务！"
    exit 1
fi
}

echo -e "
\033[33m
====================================================="
green "
1.请选择版本
2.修复2.9版本豆瓣API
3.修复3.2版本豆瓣API
"
echo "0.清除缓存并退出脚本

======================================================"

read -p "请输入以上数字[2或3]执行响应的脚本: " num
if [  $num  == 2  ]; then
2.9
elif [  $num  == 3  ]; then
3.2
elif [  $num  == 0  ]; then
rm -rf nas-tools-2.9.1.tar.gz
rm -rf nas-tools-3.2.3.tar.gz
rm -rf /douban/ 
red "我们下次再见，拜拜 "
exit 1
else
red "请输入正确的数字，启动对应功能[0-6]: "
yellow "请输入正确的数字，启动对应功能[0-6]: "
green "请输入正确的数字，启动对应功能[0-6]: "
fi