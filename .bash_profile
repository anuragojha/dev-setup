# global exports

# set java version
if [ "$(uname)" == "Darwin" ]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi

# set atom as default editor
export EDITOR="atom -w"

# download and install the latest .bash_profile
function bpupdate() {
    curl -fsSL https://raw.githubusercontent.com/anuragojha/dev-setup/master/.bash_profile -o $HOME/.bash_profile
    source ~/.bash_profile
}

# Generic Aliases
if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    alias ll='ls -laG'                                       # List all file in long list format
    alias ls='ls -G'
else
    alias ll='ls -la --color=auto'                           # List all file in long list format
    alias ls='ls --color=auto'
fi

alias h='hostname'                                           # list hostname
alias hp='echo "`hostname`:`pwd`"'                           # list hostname with path to currect directory
alias ..='cd ..'                                             # Go up one directory
alias ...='cd ../..'                                         # Go up two directories
alias ....='cd ../../..'                                     # Go up three directories
alias -- -='cd -'                                            # Go back
alias c='clear'                                              # Clear Screen
alias k='clear'                                              # Clear Screen
alias cls='clear'                                            # Clear Screen
alias _="sudo"                                               # Execute with sudo
alias q='exit'                                               # Logout
alias vi='vim'                                               # launch vim

# config utils
function disable() {
    case "$1" in
        "indexing")    
            sudo mdutil -a -i off
            ;;
            
    esac
}

function enable() {
    case "$1" in
        "indexing")    
            sudo mdutil -a -i on
            ;;
            
    esac
}

alias blame-bird='python -c "$(curl -fsSL https://raw.githubusercontent.com/bwesterb/blame-bird/master/blame-bird.py)"'

# screen
alias scl='screen -ls'

function scr() {
   if [ $@ ]; then
      screen -r $@
   else
      screen -r
   fi
}

function scd() {
  if [ $@ ]; then
     screen -d $@
  else
     screen -d
  fi
}


# date utils
function date_list() {
    DATE=$(date -d "$1" +%s);  # 2013-09-05
    END=$(date -d "$2" +%s);   # 2013-09-10
    while [[ "$DATE" -le "$END" ]]; do date -d "@$DATE" +%F; let DATE+=86400; done
}


# email
# SET alias mailme=?

source .hadoop
