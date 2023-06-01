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
wget -O ffmpeg-git-amd64-static.tar.xz https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
tar -xJvf ffmpeg-git-amd64-static.tar.xz -C /root/ffmpeg   # 解压缩到目录
if [ -f ffmpeg-git-amd64-static.tar.xz ]; then  
rm -rf ffmpeg-git-amd64-static.tar.xz   # 删除原文件  

red "*****************************************"
filename=$(ls -p /root/ffmpeg)  
green "jellyfi控制台设置FFmpeg路径设置为："
yellow "/ffmpeg/$filename"yellow "ffmpeg"
red "*****************************************"
    exit 1  
else
    bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/02_ffmpeg.sh)
    yellow "正在重试一次..."
fi