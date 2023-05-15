#!/bin/bash
# 增加颜色
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
# 清除缓存
rm -rf docker-compose-nastool.yaml
rm -rf docker-compose-tr.yaml
rm -rf docker-compose-jellyfin.yaml
rm -rf docker-compose-tmm.yaml
# 读取输入的目录和需要挂载的容器名
read -p "请输入你的docker目录: " ip_address1
read -p "请输入你的video 目录: " ip_address2
# 创建docker-compose
echo "version: '3.4'
services:
  nastools:
    image: 19970688/nastools-bt:latest
    # ports:
    #  - 3000:3000
    volumes:
      - $ip_address1/nastool:/config   # 冒号左边请修改为你想保存配置的路径
      - $ip_address2:/video # 映射数据目录
    environment:
      - PUID=0
      - PGID=0
      - TZ=Asia/Shanghai
      - UMASK=022 # 掩码权限，默认000，可以考虑设置为022
      - NASTOOL_AUTO_UPDATE=false # 关闭自动更新
      - NASTOOL_CN_UPDATE=false # 关闭自动更新
    restart: always
    network_mode: host # bridge
    hostname: 01-nastools
    container_name: 01-nastools" >> docker-compose-nastool.yaml
echo "version: '2.1'
services:
  Transmission:
    image: linuxserver/transmission:version-3.00-r8
    # ports:
    #  - 9091:9091
    volumes:
      - $ip_address1/transmission/config:/config   # 冒号左边请修改为你想保存配置的路径
      - $ip_address2:/video # 映射数据目录
    environment:
      - PUID=0
      - PGID=0
      - UMASK=022 # 掩码权限，默认000，可以考虑设置为022
      - TRANSMISSION_WEB_HOME=/config/web # WEB-UI重点设置
      - USER=admin # 用户名
      - PASS=adminadmin # 密码
    restart: always
    network_mode: host # bridge
    hostname: 02-Transmission
    container_name: 02-Transmission" >> docker-compose-tr.yaml
echo "version: '3.5'
services:
  Transmission:
    image: nyanmisaka/jellyfin:latest
    # ports:
    #  - 8096:8096
    volumes:
      - $ip_address1/jellyfin:/config   # 冒号左边请修改为你想保存配置的路径
      - $ip_address2:/video # 映射数据目录
    environment:
      - PUID=0
      - PGID=0
      - UMASK=022 # 掩码权限，默认000，可以考虑设置为022
    extra_hosts:
      - "api.themoviedb.org:13.224.167.108"
      - "api.themoviedb.org:13.35.166.12"
    restart: always
    network_mode: host # bridge
    hostname: 03-Jellyfin
    container_name: 03-Jellyfin" >> docker-compose-jellyfin.yaml
echo "version: '3.0'
services:
  Transmission:
    image: tinymediamanager/tinymediamanager:latest
    ports:
      - 4000:4000
    volumes:
      - $ip_address1/Tinymediamanager/data:/data   # 冒号左边请修改为你想保存配置的路径
      - $ip_address2/硬链接:/media # 映射数据目录
    environment:
      - USER_ID=0
      - GROUP_ID=0
      - UMASK=022 # 掩码权限，默认000，可以考虑设置为022
    extra_hosts:
      - "api.themoviedb.org:13.224.167.108"
      - "api.themoviedb.org:13.35.166.12"
    restart: always
    network_mode: bridge # host
    hostname: 04-Tinymediamanager
    container_name: 04-Tinymediamanager" >> docker-compose-tmm.yaml
# 确认目录是否正确
yellow "docker目录为: $ip_address1"
yellow "video 目录为: $ip_address2"
yellow "请确认需安装的文件夹为空白或者没有重复文件夹"
read -p "请确认目录是否正确y/n:" y
read -p "请确认是否首次安装y/n:" y2
if [ $y2 = "y" ];then
# 下载文件
wget https://wuzhuwei.work/upload/sh/docker.tar.gz
wget https://wuzhuwei.work/upload/sh/video.tar.gz
# 检测是否下载
if [ -f docker.tar.gz -a -f video.tar.gz ]; then
    yellow "下载已完成！"
    else
    yellow "下载失败，终止任务！"
    exit 1
fi

# 解压缩文件到docker目录
tar -zxf docker.tar.gz -C $ip_address1
tar -zxf video.tar.gz -C $ip_address2
# 输出解压缩成功的提示
if [ -d "$ip_address1/nastool" -o -d "$ip_address2/源文件" ]; then
    yellow "解压缩成功，文件已经存储docker目录中"
    rm docker.tar.gz
    rm video.tar.gz
    else
    yellow "解压失败，终止任务！"
    exit 1
fi
fi
# 安装容器
if [ $y = "y" ];then
yellow "所有文件已就绪！3秒后进入doker安装界面..."
sleep 3
wget https://wuzhuwei.work/upload/sh/nas/04_docker2.sh && chmod 777 ./04_docker2.sh && bash ./04_docker2.sh
elif [ $y = "n" ];then
  rm -rf ./04_docker.sh && wget https://wuzhuwei.work/upload/sh/nas/04_docker.sh && chmod 777 ./04_docker.sh && bash ./04_docker.sh ; rm -rf ./04_docker.sh
else
    echo "输入非法指令"
fi