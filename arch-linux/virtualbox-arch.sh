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

# add our user to the virtualbox group
sudo gpasswd -a $USER vboxusers

# reboot your machine and virtual box should work

# download and install the extension pack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.12.vbox-extpack 
