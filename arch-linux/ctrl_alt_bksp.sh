#!/bin/bash

# set up ctrl_alt_bksp
#=====================


# edit 00-keyboard.conf 
sudo vim /etc/X11/xorg.conf.d/00-keyboard.conf


# add Option "XkbOptions" "terminate:ctrl_alt_bksp" 
# to /etc/X11/xorg.conf.d/00-keyboard.conf

Option "XkbOptions" "terminate:ctrl_alt_bksp"