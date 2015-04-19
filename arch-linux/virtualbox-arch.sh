#!/bin/bash

# virtualbox arch linux install
#==============================


# install virtualbox
sudo pacman -S virtualbox

# modprobe
sudo modprobe vboxdrv

# load the module at boot
sudo vim /etc/modules-load.d/virtualbox.conf

# add vboxdrv to the /etc/modules-load/virtualbox.conf file
vboxdrv
vboxnetadp
vboxnetflt

# add our user to the virtualbox group
sudo gpasswd -a $USER vboxusers


# install virtualbox guest utils
sudo pacman -S virtualbox-guest-utils

# install guest iso
sudo pacman -S virtualbox-guest-iso


# install virtualbox extension pack

yaourt -S virtualbox-ext-oracle

# manually load modules
sudo su
modprobe -a vboxdrv vboxnetadp vboxnetflt 

# modules not loaded
# vboxpci vboxguest vboxsf vboxvideo


# reboot your machine and virtual box should work