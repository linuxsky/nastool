#!/bin/bash
# 下载ffmpeg
if mkdir /root/temp,then
rm -rf ffmpeg-git-amd64-static.tar.xz,then
wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz,then
tar -xvf ffmpeg-git-amd64-static.tar.xz -C /root/temp,then
rm -rf ffmpeg-git-amd64-static.tar.xz,then
find /root/temp -depth -name "ffmpeg*" -o -name "ffprobe*" -exec cp -i '{}' /usr/bin/ \;