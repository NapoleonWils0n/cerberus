#!/bin/bash

# peerflix stream torrents with vlc
#==================================

# install nodejs
sudo pacman -S nodejs

# install peerflix with npm
sudo npm install -g peerflix


# usage, surround magnet links with quotes ""

# play torrent with vlc
peerflix "magnet-link" --vlc -r


# stream torrent but dont play it
peerflix "magnet-link" -r -p 6881
