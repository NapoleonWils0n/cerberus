#!/bin/bash

# ssh x forward xfce desktop
#===========================

# on client machine ( linux laptop )
sudo vim /etc/X11/Xwrapper.config

# change from 
allowed_users=console

# to 
allowed_users=anybody

# start ssh tunnel to forward the raspberry pi desktop to your desktop
xinit /usr/bin/ssh -Y pi@pi.local lxsession -- :1
