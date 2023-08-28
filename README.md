## 一键安装docker脚本
```
wget -O password.sh https://gitee.com/juway111/nastool/raw/master/password.sh && bash password.sh
```

## 硬件解码：ffmpeg文件下载解压 
```
bash <(curl -s https://gitee.com/juway111/nastool/raw/master/nas/02_ffmpeg.sh)
```

## docker文件下载解压
```
bash <(curl -s https://gitee.com/juway111/nastool/raw/master/Download_docker_tar_gz.sh)
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