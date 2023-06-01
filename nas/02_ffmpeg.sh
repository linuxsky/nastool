#!/bin/bash
# 下载ffmpeg
mkdir ffmpeg
rm -rf ffmpeg-git-amd64-static.tar.xz && wget "https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz" && tar -xvf ffmpeg-git-amd64-static.tar.xz -C ffmpeg && rm -rf ffmpeg-git-amd64-static.tar.xz
# 移动目录
cp ffmpeg/ffmpeg /usr/bin/
cp ffmpeg/ffprobe /usr/bin/
#清除缓存
rm-rf /ffmpeg/