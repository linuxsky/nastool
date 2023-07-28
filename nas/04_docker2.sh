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

# 1.安装nastool
nastool() {
    yellow "正在安装01-nastool-bt，请稍后..."
    docker-compose -p nastool -f docker-compose-nastool.yaml up -d
    bash 04_docker2.sh
}

# 2.安装tr
tr() {
    yellow "正在安装02-tr下载器，请稍后..."
    docker-compose -p tr -f docker-compose-tr.yaml up -d
    bash 04_docker2.sh
}

# 3.安装jellyfin
jellyfin() {
    yellow "正在安装03-jellyfin播放器，请稍后..."
    docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
    bash 04_docker2.sh
}

# 4.安装tmm
tmm() {
    yellow "正在安装04-tmm搜刮器，请稍后..."
    docker-compose -p tmm -f docker-compose-tmm.yaml up -d
    bash 04_docker2.sh
}

# 5.安装所有2.9.1版本
all() {
    yellow "正在安装01-nastool，请稍后..."
    docker-compose -p nastool -f docker-compose-nastool.yaml up -d
    yellow "正在安装03-jellyfin播放器，请稍后..."
    docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
    yellow "正在安装02-qb下载器，请稍后..."
    docker-compose -p qb -f docker-compose-qb.yaml up -d
    yellow "正在安装05-jackett资源池，请稍后..."
    docker-compose -p jackett -f docker-compose-jackett.yaml up -d
    yellow "正在安装04-tmm搜刮器，请稍后..."
    docker-compose -p tmm -f docker-compose-tmm.yaml up -d
    yellow "正在安装02-tr下载器，请稍后..."
    docker-compose -p tr -f docker-compose-tr.yaml up -d
    bash 04_docker2.sh
}

# 6.安装nastool3.0
nastool3() {
    yellow "正在安装01-nastool-3.0，请稍后..."
    docker-compose -p nastool3 -f docker-compose-nastool3.yaml up -d
    bash 04_docker2.sh
}

# 7.安装nastool3.0全部
nastool3_all() {
    yellow "正在安装01-nastool-3.0，请稍后..."
    docker-compose -p nastool3 -f docker-compose-nastool3.yaml up -d
    yellow "正在安装03-jellyfin播放器，请稍后..."
    docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
    yellow "正在安装02-qb下载器，请稍后..."
    docker-compose -p qb -f docker-compose-qb.yaml up -d
    yellow "正在安装04-tmm搜刮器，请稍后..."
    docker-compose -p tmm -f docker-compose-tmm.yaml up -d
    yellow "正在安装02-tr下载器，请稍后..."
    docker-compose -p tr -f docker-compose-tr.yaml up -d
    bash 04_docker2.sh
}

# 8.安装jackett
jackett() {
    yellow "正在安装05-jackett资源池，请稍后..."
    docker-compose -p jackett -f docker-compose-jackett.yaml up -d
    bash 04_docker2.sh
}

# 9.安装nastool-3.2.5解锁版全部
nastool325() {
    yellow "正在安装01-nastool-3.2.5，请稍后..."
    docker-compose -p nastool3.2.5 -f docker-compose-nastool3.2.5.yaml up -d
    yellow "正在安装03-jellyfin播放器，请稍后..."
    docker-compose -p jellyfin -f docker-compose-jellyfin.yaml up -d
    yellow "正在安装02-qb下载器，请稍后..."
    docker-compose -p qb -f docker-compose-qb.yaml up -d
    yellow "正在安装04-tmm搜刮器，请稍后..."
    docker-compose -p tmm -f docker-compose-tmm.yaml up -d
    yellow "正在安装02-tr下载器，请稍后..."
    docker-compose -p tr -f docker-compose-tr.yaml up -d
    bash 04_docker2.sh
}

# 0.清除缓存
rm_sh() {
    rm -rf 04_docker.sh
    rm -rf 04_docker2.sh
    rm -rf docker-compose-nastool.yaml
    rm -rf docker-compose-tr.yaml
    rm -rf docker-compose-jellyfin.yaml
    rm -rf docker-compose-tmm.yaml
    rm -rf docker-compose-nastool3.yaml
    rm -rf docker-compose-qb.yaml
    rm -rf docker-compose-jackett.yaml
    rm -rf docker-compose-nastool3.2.5.yaml
}

echo " ===================================================== "
yellow "已经全部修复好大和岛，豆瓣图片问题"
green "
1.NasTool_v2.9.1_优化版
2.TR下载器
3.Jellyfin播放器
4.TMM搜刮器 "
yellow "5.全部安装Nastool_v2.9_优化版6款软件"
green "6.NasTool_v3.0+版本"
yellow "7.全部安装Nastool_v3.0+认证版5款软件"
green "8.jackett资源池 "
yellow "9.全部安装Nastool_v3.2.5定制版5款软件"
echo "0.清除缓存并返回上一层

======================================================"

read -p " 请输入以上数字，安装对应容器: " num

if [ "$num" -eq 1 ]; then  
    nastool  
elif [ "$num" -eq 2 ]; then  
    tr  
elif [ "$num" -eq 3 ]; then  
    jellyfin  
elif [ "$num" -eq 4 ]; then  
    tmm  
elif [ "$num" -eq 5 ]; then  
    all  
elif [ "$num" -eq 6 ]; then  
    nastool3  
elif [ "$num" -eq 7 ]; then  
    nastool3_all  
elif [ "$num" -eq 8 ]; then  
    jackett  
elif [ "$num" -eq 9 ]; then  
    nastool325  
elif [ "$num" -eq 0 ]; then  
    rm_sh  
    red " 清除缓存中，请稍等..."  
    exit  
else  
    red "****输入错误！请输入正确的数字，安装对应容器****"  
    bash 04_docker2.sh  
fi