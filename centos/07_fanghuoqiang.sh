#!/bin/bash  
  
# 关闭防火墙  
systemctl stop firewalld.service  
  
# 等待防火墙服务停止  
sleep 5  
  
# 关闭防火墙规则  
firewall-cmd --reload  
  
# 确认防火墙已关闭  
if pgrep firewalld > /dev/null; then  
  # 防火墙仍在运行，退出  
  exit 1  
fi
#运行成功
red() {
	echo -e "\033[31m\033[01m$1\033[0m"
}
red "=================运行结束===================="