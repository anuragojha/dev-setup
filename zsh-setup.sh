#!/bin/sh

### install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

### install powershell fonts
TMPDIR=~/temp_$$
mkdir ~/${TMPDIR}
cd ~/${TMPDIR}
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts

### other goodies
brew install zsh-syntax-highlighting

cat << EOF
###### ADDITIONAL CONFIGS REQUIRED #######
update ~/.zshrc
    ZSH_THEME="agnoster"
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

update iterm
    Set color scheme to solarized
    Set Text font to Menlo powershell 12pt
###########################################
EOF
