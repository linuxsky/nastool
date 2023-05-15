#/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo    
sudo yum-config-manager --enable docker-ce-nightly
sudo yum install docker-ce docker-ce-cli containerd.io
systemctl start docker  #启动容器
systemctl enable docker #开机自启
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker --version
docker-compose --version 
#定义颜色
green() {
	echo -e "\033[32m\033[01m$1\033[0m"
}
red() {
	echo -e "\033[31m\033[01m$1\033[0m"
}
yellow() {
	echo -e "\033[33m\033[01m$1\033[0m"
}
#运行成功
yellow "Docker 和 Docker-compose 已经安装，运行成功！"
red "=================运行结束===================="