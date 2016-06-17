#!/bin/bash

# unistall xf86-input-synaptics
sudo pacman -Rsn xf86-input-synaptics

# move any config files from /etc/X11/xorg.conf.d to your desktop

# install xf86-input-libinput
sudo pacman -S xf86-input-libinput

# move config files from your desktop to /etc/X11/xorg.conf.d
# log out and back in again
