#!/bin/bash

# docker install
#===============

# install docker
sudo pacman -S docker

# add your user to the docker group, 
#replace username with your username

sudo gpasswd -a username docker
