#!/bin/bash


# mplayer hardware acceleration
#==============================


# install libvdpau-va-gl for intel cards
sudo pacman -S libvdpau-va-gl


# create vdpau_vaapi.sh 
sudo vim /etc/profile.d/vdpau_vaapi.sh

#!/bin/sh
export VDPAU_DRIVER=va_gl


# make the script executable
sudo chmod +x /etc/profile.d/vdpau_vaapi.sh



# add to ~/.mplayer/config
vim  ~/.mplayer/config

vo=vdpau,


# reboot