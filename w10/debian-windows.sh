#!/bin/bash
# change DNS
cat << EOF > /etc/resolv.conf
#nameserver 223.6.6.6
nameserver 223.5.5.5 
nameserver 1.1.1.1
EOF

# change repo
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cat << EOF > /etc/apt/sources.list
deb http://mirrors.aliyun.com/debian stretch main contrib non-free
deb http://mirrors.aliyun.com/debian stretch-proposed-updates main contrib non-free
deb http://mirrors.aliyun.com/debian stretch-updates main contrib non-free

deb-src http://mirrors.aliyun.com/debian stretch main contrib non-free
deb-src http://mirrors.aliyun.com/debian stretch-proposed-updates main contrib non-free
deb-src http://mirrors.aliyun.com/debian stretch-updates main contrib non-free

deb http://mirrors.aliyun.com/debian-security/ stretch/updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian-security/ stretch/updates main non-free contrib
EOF

# install app
apt upgrade -y && apt-get dist-upgrade -y && apt update -y  && apt install -y  vim curl wget ssh bash-completion git dos2unix

############################install zsh##################
# install zsh 
apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zshrc.bak
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
#chsh -s /bin/zsh

# install zsh-syntax-highlighting and zsh-autosuggestions
cd ~/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -f ~/.zshrc
wget https://raw.githubusercontent.com/owelinux/tools/master/zsh/.zshrc
#source ~/.zshrc

# install zpm and dircolors-material
if [ ! -f ~/.zpm/zpm.zsh ]; then
  git clone --recursive https://github.com/horosgrisa/zpm ~/.zpm
fi
source ~/.zpm/zpm.zsh
zpm load zpm-zsh/dircolors-material

##########################################################

# install docker
curl -sSL https://get.docker.com/ | sh
systemctl  enable docker.service 
systemctl  restart docker.service 
chmod +x /usr/share/bash-completion/bash_completion

# install kubectl helm
cd /usr/local/bin
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get |bash
chmod +x /usr/local/bin/kubectl
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

rm -rf .helm
helm init --stable-repo-url https://burdenbear.github.io/kube-charts-mirror/
helm repo add registry-chart  https://registry-chart.mypaas.com.cn --username='admin' --password='admin@chart2019'
helm repo update
helm plugin install https://github.com/chartmuseum/helm-push
source <(helm completion bash)
echo "source <(helm completion bash)" >> ~/.bashrc

#stop ipv6
echo "blacklist ipv6" >> /etc/modprobe.d/blacklist 

#config limits
ulimit -n 65535
LIMIT=`awk -F' ' '/nofile  65535/{print $1}' /etc/security/limits.conf | head -n 1`
if [ -z ${LIMIT} ];then
    echo '*        soft    nofile  65535' >> /etc/security/limits.conf
    echo '*        hard    nofile  65535' >> /etc/security/limits.conf
fi

# config_bash
cat << EOF >> /home/v2ray/.profile
PS1='${debian_chroot:+($debian_chroot)}\h@\u:\w\$ '
EOF
echo "alias ll='ls -l --color=auto'" >> /etc/profile
echo "alias ls='ls --color=auto'" >> /etc/profile

source ~/.zshrc
