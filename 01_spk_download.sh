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
read -p "请输入存储空间volume序号: " ip_address1
read -p "请输入文件夹名称: " ip_address2
# 确认目录是否正确
green "==================================================="
echo -e "你输入的下载目录为: \033[33m/volume$ip_address1/$ip_address2\033[0m"
yellow "请确认目录是否正确"
read -p "若目录正确，请按 Y 继续，按 N 重试 ：" y
# 下载文件
if [ $y = "y" ];then
    rm -rf /volume$ip_address1/$ip_address2/nastool_2.9.1_x64-DSM7.spk && wget -c https://d.nastool.work/d/%E9%98%BF%E9%87%8C%E4%BA%91%E7%9B%98/%E9%98%BF%E9%87%8C%E4%BA%91%E7%9B%98%E5%90%8C%E6%AD%A5/1.%E6%B8%B8%E5%AE%A2%E4%B8%8B%E8%BD%BD/SSH%E5%B7%A5%E5%85%B7/wget%E4%B8%8B%E8%BD%BD%E7%9B%AE%E5%BD%95/nastool_2.9.1_x64-DSM7.spk -O /volume$ip_address1/$ip_address2/nastool_2.9.1_x64-DSM7.spk
# 检测是否下载
if [ -f /volume$ip_address1/$ip_address2/nastool_2.9.1_x64-DSM7.spk ]; then
    yellow "下载已完成！"
else
    yellow "下载失败，终止任务！"
    exit 1
fi
elif [ $y = "n" ];then
  red "目录设置错误，请重新设置！"
  bash <(curl https://gitee.com/juway111/nastool/raw/master/01_spk_download.sh)
else
    echo "输入非法指令"
fi
#0.清除缓存
yellow "已下载，等待清除缓存..."
read -p "按 Y 清除缓存 ：" y
if [ $y = "y" ];then
    rm -rf /volume$ip_address1/$ip_address2/nastool_2.9.1_x64-DSM7.spk
else
exit 1
fi