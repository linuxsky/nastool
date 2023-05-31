#!/bin/bash
# && docker pull 
# docker pull emby/embyserver:beta && docker pull nastool/nas-tools:latest && docker pull xhofe/alist:v3.18.0 && docker pull nyanmisaka/jellyfin:latest && docker pull tinymediamanager/tinymediamanager:latest && docker pull halohub/halo:1.6.1 && docker pull 80x86/typecho:latest && docker pull linuxserver/heimdall:2.4.13 && docker pull homeassistant/home-assistant:latest && docker pull linuxserver/calibre-web:latest && docker pull iyuucn/iyuuplus:latest && docker pull linuxserver/heimdall:2.4.13 && docker pull linuxserver/transmission:version-3.00-r8 && docker pull likun7981/hlink:latest
echo "{"data-root": "/vfs/PART3_208G/docker/image","registry-mirrors":["https://registry.docker-cn.com","https://pee6w651.mirror.aliyuncs.com"]}" >> /etc/docker/daemon.json
