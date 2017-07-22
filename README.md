# dev-setup

fetch bash_profile file
```bash
curl -fsSL https://raw.githubusercontent.com/anuragojha/dev-setup/master/.bash_profile -o $HOME/.bash_profile
```

install brew packages
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/anuragojha/dev-setup/master/brew-setup.sh)"
```

install atom plugins
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/anuragojha/dev-setup/master/atom-setup.sh)"
```

setup oh-my-zsh on iterm2 with solarized colors, agnoster theme and syntax highlighting
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/anuragojha/dev-setup/master/zsh-setup.sh)"
```


