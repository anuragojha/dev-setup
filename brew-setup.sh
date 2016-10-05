echo "Installing brew "
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Cask "
brew install caskroom/cask/brew-cask
brew tap caskroom/cask
brew tap caskroom/versions

echo "Updating app lists"
brew update
brew upgrade
brew cask update

echo "Installing apps"
brew cask install atom
brew cask install textmate
brew cask install libreoffice
brew cask install evernote
brew cask install adobe-reader

brew cask install java
brew cask install caskroom/versions/java7
brew install python
brew cask install iterm2
brew cask install github-desktop
brew cask install pycharm-ce
brew cask install intellij-idea-ce
brew cask install sourcetree
brew install rbenv ruby-build
brew install maven
brew install ant

brew cask install skype
brew cask install google-hangouts
brew cask install google-chrome
brew cask install google-drive

brew install wget
brew install aria2
brew cask install transmit
brew cask install transmission

brew cask install alfred
brew cask install flux
brew cask install dash
brew cask install nosleep
brew cask install istat-menus

brew cask install xee
brew cask install steam
brew cask install vlc
brew install ffmpeg
brew cask install plex-media-server
brew cask install spotify
brew cask install audacity
brew cask install gimp
brew cask install imageoptim
brew cask install keka
brew cask install the-unarchiver

echo "Final Check/ Running brew doctor."
brew doctor

echo "Clean downloaded files."
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
