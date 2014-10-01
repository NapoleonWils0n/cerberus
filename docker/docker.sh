#!/bin/bash

# docker install
#===============

# install docker
sudo pacman -S docker

# add your user to the docker group, 
#replace username with your username

sudo gpasswd -a username docker

# start docker
sudo systemctl start docker

# stop docker
sudo systemctl stop docker

# run ubuntu
docker run -it ubuntu:14.04 /bin/bash

# find docker container ip address
docker inspect -f '{{ .NetworkSettings.IPAddress }}' container_name
