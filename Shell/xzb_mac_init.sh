#! /bin/bash

function echo_yellow()
{
    echo -e "-------> \033[33m $1 \033[1m"
}

echo_yellow "Quick Look plugins"
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json webpquicklook suspicious-package quicklookase qlvideo

echo_yellow "Mac App Store command line interface"
brew install mas

echo_yellow "brew install fish"
brew install fish

echo_yellow "Homebrew 图形工具"
brew cask install cakebrew

echo_yellow "A code search tool"
 brew install pt