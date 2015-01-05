#!/bin/bash

# xbmc-send video urls to xbmc
#=============================


# install xbmc-send
sudo apt-get install xbmc-eventclients-xbmc-send 


# change --host=192.168.1.4 to the ip address of your xbmc machine 

# Play - Pause toggle
xbmc-send --host=192.168.1.4 --port=9777 --action="PlayerControl(Play)"

# play video url
xbmc-send --host=192.168.1.4 --port=9777 --action="PlayMedia(https://example.com/video.mp4)"

# play youtube video with youtube-dl subshell
xbmc-send --host=192.168.1.4 --port=9777 --action="PlayMedia($(youtube-dl -g "https://www.youtube.com/watch?v=-ve_H-Ua6pQ"))"


# bash functions for ~/.bashrc
#=============================


# xbmc-send play video url
function xbmc-send-url {
xbmc-send --host=192.168.1.4 --port=9777 --action="PlayMedia("$1")"
}

# xbmc-send play youtube videos with youtube-dl
function xbmc-send-youtube {
xbmc-send --host=192.168.1.4 --port=9777 --action="PlayMedia($(youtube-dl -g "$1"))"
}
