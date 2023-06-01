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
# 下载ffmpeg  
rm -rf /root/ffmpeg        # 删除目录
mkdir /root/ffmpeg         # 创建目录  
wget -O ffmpeg-git-amd64-static.tar.xz https://12312312312johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz

if [ -f ffmpeg-git-amd64-static.tar.xz ]; then  
tar -xJvf ffmpeg-git-amd64-static.tar.xz -C /root/ffmpeg   # 解压缩到目录
red "*****************************************"
filename=$(ls -p /root/ffmpeg)  
green "jellyfi控制台设置FFmpeg路径设置为："
yellow "/ffmpeg/$filename"ffmpeg
red "*****************************************"
sleep 2
rm -rf ffmpeg-git-amd64-static.tar.xz   # 删除原文件  
else
    yellow "下载失败，再试一次吧！"
fi