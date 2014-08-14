#!/bin/bash

# enable multilb for 32 bit applications
#=======================================

sudo vim /etc/pacman.conf

# uncomment the multilib section
[multilib]
Include = /etc/pacman.d/mirrorlist

# update the package list and upgrade
sudo pacman -Syu
