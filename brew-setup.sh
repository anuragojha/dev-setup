# get brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# get cask
brew tap caskroom/cask

# update
brew update
brew upgrade

# install apps
brew cask install evernote
brew cask install vlc
brew cask install iterm2
brew cask install alfred
brew cask install adobe-reader
brew cask install atom
brew cask install audacity
brew cask install flux
brew cask install gimp
brew cask install github
brew cask install github-desktop
brew cask install pycharm
brew cask install intellij-idea
brew cask install sourcetree
brew cask install spotify
brew cask install skype
brew cask install textmate
brew cask install utorrent
brew cask install google-hangouts
brew cask install google-chrome
brew cask install google-drive
brew cask install dash
brew cask install keka
brew cask install imageoptim
brew cask install transmit
brew cask install java
brew cask install openoffice
brew cask install steam

# verify 
brew doctor

# link cask apps to alfred
brew cask alfred link

# cleanup
brew cleanup

# install developer command line tools
xcode-select --install


# misc apps
#   magnet
#   Go2Shell

# chrome apps
#   auto refresh
#   proxy switchyomega
#   ublock origin
#   tinyeye
