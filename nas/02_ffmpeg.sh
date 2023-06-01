#!/bin/bash  

# 这个是副本，需要同步更新才可以
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
wget -O ffmpeg-git-amd64-static.tar.xz https://123123johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz

# 指定要查找的文件名和目录路径  
file_to_find="ffmpeg"  
directory="/root/ffmpeg"  
  
# 遍历目录下的所有文件和子文件夹  
for file in $(find "$directory" -type f -name "$file_to_find")  
do  
  # 判断文件是否存在  
  if [ -f "$file" ]; then  
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
done