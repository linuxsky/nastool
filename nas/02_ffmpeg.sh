#!/bin/bash
# 下载ffmpeg
if mkdir /root/temp && rm -rf ffmpeg-git-amd64-static.tar.xz && wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz && tar -xvf ffmpeg-git-amd64-static.tar.xz -C /root/temp && rm -rf ffmpeg-git-amd64-static.tar.xz && find /root/temp -depth -name "ffmpeg*" -o -name "ffprobe*" -exec cp -i '{}' /usr/bin/