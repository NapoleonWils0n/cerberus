#!/bin/bash

# set keyboard layout for mac
#============================

sudo vim /etc/default/keyboard

XKBMODEL="pc105"
XKBLAYOUT="gb"
XKBVARIANT="mac"
XKBOPTIONS=""


# setxkbmap to swap control with cmd
#===================================

setxkbmap -option altwin:ctrl_win

# run setxkbmap at startup

# open session and startups
# open the application autostart tab
# click the add button, and fill in the following fields

# name: setxkbmap ctrl
# description: swap ctrl with cmd
# command: /usr/bin/setxkbmap -option altwin:ctrl_win


# change whisker menu to use right cmd
#=====================================

sudo vim /usr/share/mint-configuration-xfce/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

# change name="Super_L"
<property name="Super_L" type="string" value="xfce4-popup-whiskermenu"/>

# to name="Control_R"
<property name="Control_R" type="string" value="xfce4-popup-whiskermenu"/>

Then logout and login.


