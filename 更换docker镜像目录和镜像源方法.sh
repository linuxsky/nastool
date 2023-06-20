#!/bin/bash

ls /etc/docker/daemon.json
echo "{
    "data-root": "/vfs/PART3_208G/docker/image",
    "registry-mirrors":["https://registry.docker-cn.com","https://mirror.baidubce.com"]
    }" >> /etc/docker/daemon.json
# /vfs/PART3_208G/docker/image这里更换为自己的镜像目录