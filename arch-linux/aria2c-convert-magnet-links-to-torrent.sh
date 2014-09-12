#!/bin/bash

# aria2c downloader install
#==========================

# convert magnet links to torrent files with aria2c


# install aria2c
sudo pacman -S aria2c

# create the aria2 directory and config file
mkdir -p ~/.aria2
touch ~/.aria2/aria2.config

# edit ~/.aria2/aria2.config
vim ~/.aria2/aria2.config

# add the following, replace username with your your username

continue
dir=/home/username/Downloads
file-allocation=none
log-level=warn
max-connection-per-server=4
min-split-size=5M
on-download-complete=exit


# convert magnet file to torrent
aria2c --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881 'magnet link url goes here'

# create a bash alias to make things easier in ~/.bashrc
vim ~/.bashrc

# convert magnet 
alias mag2torrent='aria2c --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881'

# create a bash function  to make things easier in ~/.bashrc
vim ~/.bashrc


# convert magnet link to torrent
#===============================

# mag2torrent
function mag2torrent {
aria2c --bt-metadata-only=true --bt-save-metadata=true --listen-port=6881 "$1"
}


# reload ~/.bashrc
source ~/.bashrc


# convert the magnet link to a torrent
#=====================================

# run the mag2torrent bash alias and pass in a magnet link 
mag2torrent magnet-link-goes-here

# this will create a .torrent file in the dir you specified in ~/.aria2/aria2.config

# the torrent file name is the hash followed by the .torrent extension
# when you convert the magnet file to a torrent it will give real file name in the terminal
# so just copy the real filename from the terminal and then rename the .torrent file
