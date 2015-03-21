#!/bin/bash


# remap left ctrl key on macbook to right click
#==============================================

# install xkbset
sudo pkg_add -i xkbset

# use xev to find keycode

# use xmodmap to bind key to mouse button
xmodmap -e "keycode 37 = Pointer_Button3"

# set keys for a session
xkbset m
xkbset exp =m


# remap keys permantly by adding code to ~/.bashrc

vim ~/.bashrc
 

# map left ctrl on right click
xmodmap -e "keycode 37 = Pointer_Button3"
xkbset m
xkbset exp =m
