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
read -p "请输入你的docker目录: " ip_address1
read -p "若目录正确，请按 Y 继续，按 N 重试 ：" y

if [ $y = "y" ];then
rm -rf $ip_address1/jellyfin/ffmpeg
mkdir $ip_address1/jellyfin/ffmpeg
rm -rf ffmpeg-git-amd64-static.tar.xz

# 下载ffmpeg
wget -O ffmpeg-git-amd64-static.tar.xz https://d.juway.top/d/nastool/Cloud%20Sync/1.Alist/wget/nastool/ffmpeg-git-amd64-static.tar.xz

# 原下载地址备份https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
yellow "解压中，请稍后..."
tar -Jxf ffmpeg-git-amd64-static.tar.xz -C "$ip_address1/jellyfin/ffmpeg"  

# 指定要查找的文件名和目录路径  
file_to_find="ffmpeg"  
directory="$ip_address1/jellyfin/ffmpeg"  
  
# 遍历目录下的所有文件和子文件夹  
for file in $(find "$directory" -type f -name "$file_to_find")  
do  
  # 如果解压文件存在的话  
if [ -f "$file" ]; then  
    red "*****************************************"
    filename=$(ls -p $ip_address1/jellyfin/ffmpeg)  
    green "jellyfi控制台设置FFmpeg路径设置为："
    yellow "/config/ffmpeg/$filename"ffmpeg
    red "*****************************************"
    sleep 2
    rm -rf ffmpeg.sh
    rm -rf ffmpeg-git-amd64-static.tar.xz   # 删除原文件  
else
    yellow "下载失败，再试一次吧！"
fi
done
else
    bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/02_ffmpeg.sh)
    bash ffmpeg.sh
fi