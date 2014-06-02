#!/bin/bash

# tor install linux mint 15
#==========================

# add tor repository to sources.list
sudo vim /etc/apt/sources.list

# add the following to your /etc/sources.list
deb     http://deb.torproject.org/torproject.org raring main

# add the gpg keys
gpg --keyserver keys.gnupg.net --recv 886DDD89
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -

# apt-get update
sudo apt-get update

# install the Debian package to help you keep our signing key current.
sudo apt-get install deb.torproject.org-keyring

# install tor
sudo apt-get install tor

# copy tor config to home directory
cp /etc/tor/torrc ~/.torrc

# start tor with the config file in your home directory
tor -f ~/.torrc

# create a bash alias for tor
vim ~/.bashrc

alias tor="tor -f ~/.torrc"

# update your ~/.bashrc
source ~/.bashrc
