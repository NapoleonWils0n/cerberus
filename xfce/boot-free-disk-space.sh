#!/bin/bash

# free disk space on /boot
#=========================

# find the ketnal you are using
uname -r

# show free space 
df -h

# grep linux-image
dpkg -l | grep linux-image

# remove old kernal versions, replace x.x.x-xx with the version number to delete
sudo apt-get purge linux-image-x.x.x-xx-generic

# remove the last kernal version
sudo apt-get purge linux-image-3.13.0-24-generic
