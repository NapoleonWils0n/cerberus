#!/bin/bash

# mplayer https
#==============


curl --ciphers RC4-SHA "$(youtube-dl -g https://www.youtube.com/watch?v=JWsRz3TJDEY)" | mplayer - 




# mplayer youtube-dl function for ~/.bashrc
#===========================================


function youtube-mplayer {
curl --ciphers RC4-SHA  $(youtube-dl -g "$1") | mplayer -cache 8192 -
}
