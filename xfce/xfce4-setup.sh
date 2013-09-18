#!/bin/bash

# xfce4 power manager install
sudo apt-get install xfce4-power-manager

# Settings / Settings Editor / xsettings / Gtk / KeyThemeName
# Click Edit property
# Change value to Emacs

vim ~/.xmodmap

remove control = Control_L
remove mod4 = Super_L Super_R
keysym Control_L = Super_L
keysym Super_L = Control_L
keysym Super_R = Control_L
add control = Control_L Control_R
add mod4 = Super_L Super_R

xmodmap ~/.xmodmap


# On my Ubuntu box I went to System > Preferences > Sessions which brought up a dialog box. 
# On the “Startup Programs” tab click the “+Add” button. 
# Name it whatever you want but in the command field type xmodmap ~/.xmodmap.

# add seahorse for ssh keys to bashrc
vim ~/.bashrc

export `gnome-keyring-daemon --start`
