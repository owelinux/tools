# zsh 优化
## install zsh 
```bash
apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zshrc.bak
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh
```
## install zsh-syntax-highlighting and zsh-autosuggestions
```bash
cd ~/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
source ~/.zshrc
```
## install zpm and dircolors-material
```bash
if [[ ! -f ~/.zpm/zpm.zsh ]]; then
  git clone --recursive https://github.com/horosgrisa/zpm ~/.zpm
fi
source ~/.zpm/zpm.zsh
zpm load zpm-zsh/dircolors-material
```

## 插件
z: 支持 z 跳转，类似 autojump
extract: 解压命令，可根据扩展名自动执行相应解压命令，alias 为 x
sudo: 按两次 ESC 可在命令前面添加 sudo
history: 增加几个查看历史的 alias: h, hs, hsi
colored-man-pages: 给 man 页面着色
zsh_reload: 提供 src 命令用于重载 zsh 配置
zsh-navigation-tools: CTRL+R 可打开 history 面板，功能很多很强大
zsh-syntax-highlighting: 命令着色
zsh-autosuggestions: 自动建议
dircolors-material: 美化 ls 输出的列表

## 主题
ys
agnoster
avit
blinks

## 开启插件
plugins=(z colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-navigation-tools git docker kubectl)

## 参考
[https://github.com/someok/oh-my-zsh-custom](https://github.com/someok/oh-my-zsh-custom)