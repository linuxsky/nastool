#!/bin/bash
# 下载ffmpeg
wget "https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz"
# 解压
tar -xvf ffmpeg-git-amd64-static.tar.xz -C ffmpeg
# 移动目录
cp ffmpeg/ffmpeg /usr/bin/
cp ffmpeg/ffprobe /usr/bin/
#清除缓存
rm-rf ffmpeg-git-amd64-static.tar.xz && rm-rf /ffmpeg/