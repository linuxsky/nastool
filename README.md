## 一键安装docker脚本
```
wget -O start.sh https://gitee.com/juway111/nastool/raw/master/bash_start.sh && bash start.sh
```
## 硬件解码：ffmpeg文件下载解压 
```
bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/02_ffmpeg.sh)
```
## 豆瓣API修复
```
# 对外链接不用动
bash <(curl -s https://juway.top/upload/2023/07/douban.sh)
```
```
wget -O douban.sh https://gitee.com/juway111/nastool/raw/master/nas/douban/douban.sh && bash douban.sh
```
## docker文件下载解压
```
bash <(curl -s https://gitee.com/juway111/nastool/raw/master/02_tar_docker.sh)
```

# 一些问题的解决方案
1. 群辉无法使用wget的情况
```
##卸载原有wget
ipkg remove wget

##安装支持https的wget
ipkg install wget-ssl

##禁用 HTTPS 证书验证
wget --no-check-certificate https://...
```