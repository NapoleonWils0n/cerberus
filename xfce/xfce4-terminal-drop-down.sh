#!/bin/bash

# xfce4 terminal with drop down 
#==============================

# You can assign a keyboard shortcut for summoning the terminal (Settings Manager > Keyboard > Application Keyboard Shortcuts). 

# create a new new keyboard and paste in this command
xfce4-terminal --drop-down

# then set the keyboard hotkey
# eg: cmd + space

# open the drop down terminal with the hotkey and then right click on the terminal and select preferences

# set the height, width and position for the terminal
# deselect always show tabs


# xfce terminal drop down fullscreen keyboard hotkey
#===================================================

# edit the ~/.gtkrc-xfce file and add a hotkey for fullsceen
vim ~/.gtkrc-xfce

# paste in the following code to set cmd + return as a fullscreen hotkey in the xfce4 terminal drop down
gtk-can-change-accels=1
(gtk_accel_path "<Actions>/terminal-window/fullscreen" "<Primary>Return")
