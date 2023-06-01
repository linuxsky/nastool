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
rm -rf /root/temp        # 删除/root/temp目录（如果不存在）  
mkdir /root/temp         # 创建/root/temp目录  
wget -O ffmpeg-git-amd64-static.tar.xz https://1johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz   # wget下载ffmpeg，保存到ffmpeg-git-amd64-static.tar.xz  
tar -xJvf ffmpeg-git-amd64-static.tar.xz -C /root/temp   # 解压缩到/root/temp目录
if [ -f ffmpeg-git-amd64-static.tar.xz ]; then  
rm -rf ffmpeg-git-amd64-static.tar.xz   # 删除原文件  

if [ -d "/root/temp" ]; then   # 如果/root/temp目录存在  
    find /root/temp -depth -name "ffmpeg*" -o -name "ffprobe*" -exec cp -i '{}' /usr/bin/ \;   # 在/root/temp目录下查找ffmpeg和ffprobe文件，并复制到/usr/bin/目录  
    yellow "任务完成！"   # 完成任务，输出黄色提示  
else  
    yellow "解压失败，终止任务！"   # 如果没有/root/temp目录，输出黄色提示并终止任务  
    exit 1  
fi

else
    bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/02_ffmpeg.sh)
    yellow "正在重试一次..."
fi