#!/bin/bash

# 下载ffmpeg
rm -rf /root/temp && mkdir /root/temp && rm -rf ffmpeg-git-amd64-static.tar.xz && wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz && tar -xvf ffmpeg-git-amd64-static.tar.xz -C /root/temp && rm -rf ffmpeg-git-amd64-static.tar.xz
if [ -d "/root/temp" ]; then
    find /root/temp -depth -name "ffmpeg*" -o -name "ffprobe*" -exec cp -i '{}' /usr/bin/ \;
    else
    yellow "解压失败，终止任务！"
    exit 1
fi