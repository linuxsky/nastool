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
# 清除缓存
rm -rf docker-compose-nastool.yaml
rm -rf docker-compose-tr.yaml
rm -rf docker-compose-jellyfin.yaml
rm -rf docker-compose-tmm.yaml
rm -rf docker-compose-nastool3.yaml
rm -rf docker-compose-qb.yaml
rm -rf docker-compose-jackett.yaml
# 读取输入的目录和需要挂载的容器名
read -p "请输入你的docker目录: " ip_address1
read -p "请输入你的video 目录: " ip_address2
# 创建docker-compose
echo "version: '3.3'
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
    hostname: 01-nastools-bt
    container_name: 01-nastools-bt" >> docker-compose-nastool.yaml
echo "version: '2.1'
services:
  Transmission:
    image: linuxserver/transmission:4.0.3
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
echo "version: '3.3'
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
    container_name: 04-Tinymediamanager-4000" >> docker-compose-tmm.yaml
echo "version: '3.3'
services:
  nastools3.0:
    image: nastool/nas-tools:latest
    # ports:
    #  - 3000:3000
    volumes:
      - $ip_address1/nastool-3.0:/config   # 冒号左边请修改为你想保存配置的路径
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
    hostname: 01-nastools-3.0
    container_name: 01-nastools-3.0" >> docker-compose-nastool3.yaml
echo "version: '2.1'
services:
  qbittorrent:
    image: johngong/qbittorrent:latest
    # ports:
    #  - 8989:8989
    volumes:
      - $ip_address1/qbittorrent:/config   # 冒号左边请修改为你想保存配置的路径
      - $ip_address2:/video # 映射数据目录
    environment:
      - UID=0
      - GID=0
      - UMASK=022 # 掩码权限，默认000，可以考虑设置为022
      - QB_WEBUI_PORT=8989
      - QB_EE_BIN=false
    restart: always
    network_mode: host # bridge
    hostname: 02-qbittorrent-8989
    container_name: 02-qbittorrent-8989" >> docker-compose-qb.yaml
echo "version: '2.1'
services:
   jackett:
    image: linuxserver/jackett:latest
    # ports:
    #  - 9117:9117
    volumes:
      - $ip_address1/jackett:/config   # 冒号左边请修改为你想保存配置的路径
      - $ip_address1/jackett/torrent:/downloads # 映射种子目录
    environment:
      - UID=0
      - GID=0
      - UMASK=022 # 掩码权限，默认000，可以考虑设置为022
      - AUTO_UPDATE=true
    restart: always
    network_mode: host # bridge
    hostname: 05-jackett-9117
    container_name: 05-jackett-9117" >> docker-compose-jackett.yaml

# 确认目录是否正确
green "==================================================="
docker --version
docker-compose --version 
echo -e "你输入的docker目录为: \033[33m$ip_address1\033[0m"
echo -e "你输入的video 目录为: \033[33m$ip_address2\033[0m"
yellow "1.请确认需安装的文件夹为空白或者没有重复文件夹
2.请确认目录是否正确"
read -p "首次安装，须下载配置文件，按 Y 下载：" y2
read -p "若目录正确，请按 Y 继续，按 N 重试 ：" y

# 下载文件
if [ $y2 = "y" ];then
    rm -rf docker.tar.gz && wget -c https://d.juway.top/d/nastool/Cloud%20Sync/1.Alist/wget/nastool/docker.tar.gz -O docker.tar.gz
    rm -rf video.tar.gz && wget -c https://d.juway.top/d/nastool/Cloud%20Sync/1.Alist/wget/nastool/video.tar.gz -O video.tar.gz
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
    rm -rf docker.tar.gz
    rm -rf video.tar.gz
    else
    yellow "解压失败，终止任务！"
    exit 1
fi
fi
# 安装容器
if [ $y = "y" ];then
rm -rf docker.tar.gz
rm -rf video.tar.gz
yellow "所有文件已就绪！正在清除下载缓存！2秒后进入doker安装界面..."
sleep 2
  bash 04_docker2.sh
elif [ $y = "n" ];then
  red "目录设置错误，请重新设置！"
  bash 04_docker.sh
else
    echo "输入非法指令"
fi