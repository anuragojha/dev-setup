#!/bin/sh

# install developer command line tools
xcode-select --install

# mac config
brew install dockutil
dockutil --remove all   # cleanup doc bar on fresh install
