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
# 读取输入的目录和需要挂载的容器名
read -p "请输入jellyfin安装目录: " ip_address1
# 确认目录是否正确
green "==================================================="
echo -e "你输入的video 目录为: \033[33m$ip_address1\033[0m"
yellow "请确认目录是否正确"
read -p "若目录正确，请按 Y 继续，按 N 重试 ：" y
if [ -d "$ip_address1/@appdata/Jellyfin/data/plugins/configurations/" ]; then
    yellow "检查目录存在，可以安装字幕插件"
    rm -rf jellyfin.MeiamSub-1.0.9.0.tar.gz
    else
    yellow "目录不存在，请检查套件是否正确安装！"
    exit 1
fi
# 下载文件
if [ $y = "y" ];then
    rm -rf jellyfin.MeiamSub-1.0.9.0.tar.gz && wget -c https://wuzhuwei.work/upload/sh/jellyfin.MeiamSub-1.0.9.0.tar.gz -O jellyfin.MeiamSub-1.0.9.0.tar.gz
# 检测是否下载
if [ -f jellyfin.MeiamSub-1.0.9.0.tar.gz ]; then
    yellow "下载已完成！"
else
    yellow "下载失败，终止任务！"
    exit 1
fi

# 解压缩文件到docker目录
tar -zxf jellyfin.MeiamSub-1.0.9.0.tar.gz -C $ip_address1/@appdata/Jellyfin/data/plugins/configurations
# 输出解压缩成功的提示
if [ -d "$ip_address1/@appdata/Jellyfin/data/plugins/configurations/MeiamSub.Shooter" -o -d "$ip_address1/@appdata/Jellyfin/data/plugins/configurations/MeiamSub.Thunder" ]; then
    yellow "解压缩成功，文件已经存储$ip_address1/@appdata/Jellyfin/data/plugins/configurations中"
    rm -rf jellyfin.MeiamSub-1.0.9.0.tar.gz
    chmod -R 775 $ip_address1/@appdata/Jellyfin/data/plugins/configurations
    else
    yellow "解压失败，终止任务！"
    exit 1
fi
# 安装容器
rm -rf jellyfin.MeiamSub-1.0.9.0.tar.gz
yellow "请重启jellyfin生效
所有文件已就绪！正在清除下载缓存..."
sleep 2
elif [ $y = "n" ];then
  red "目录设置错误，请重新设置！"
  bash <(curl https://gitee.com/juway111/nastool/raw/master/nas/jellyfin.MeiamSub-1.0.9.0.sh)
else
    echo "输入非法指令"
fi