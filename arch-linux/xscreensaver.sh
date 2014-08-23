#!/bin/bash

# xscreensaver
#=============

# install xscreensaver
sudo pacman -S xscreensaver 


# edit ~/.xinitrc
vim ~/.xinitrc

# add the following code to ~/.xinitrc to autostart xscreensaver
/usr/bin/xscreensaver -no-splash &


# run the xscreensaver-demo
xscreensaver-demo

# change the settings which creates the ~/.xscreensaver file


# lock the screen
xscreensaver-command --lock
