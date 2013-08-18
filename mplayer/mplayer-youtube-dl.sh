#!/bin/bash

# play youtube videos in mplayer with youtube-dl
#===============================================

# download the youtube-del script
#================================

# http://rg3.github.io/youtube-dl/

# use wget to download the youtube-dl script to your home bin directory
wget http://youtube-dl.org/downloads/2013.08.17/youtube-dl -O ~/bin/yoUtube-dl

# make the script executable
chmod +x ~/bin/youtube-dl

# source your .bashrc file
source ~/.bashrc

# use the script to download a video
youtube-dl videourl


# play youtube videos in mplayer
#===============================

# url is the youtube link passed as an argument to the script
mplayer $(youtube-dl -g "$1") 


# usage
mplayer-youtube https://www.youtube.com/watch?v=dQw4w9WgXcQ
