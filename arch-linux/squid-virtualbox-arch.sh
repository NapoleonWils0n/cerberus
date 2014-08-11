#!/bin/bash


# download the qlproxy virtual machine
# http://www.quintolabs.com/virtual.php



# install virtualbox
sudo pacman -S virtualbox

# modprobe
sudo modprobe vboxdrv

# load the module at boot
sudo vim /etc/modules-load.d/virtualbox.conf

# add vboxdrv to the /etc/modules-load.d/virtualbox.conf file
vboxdrv

# add our user to the virtualbox group
sudo gpasswd -a $USER vboxusers

# reboot your machine and virtual box should work

# download and install the extension pack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.12.vbox-extpack 


# install net-tools
sudo pacman -S net-tools

# install guest utils
sudo pacman -S virtualbox-guest-utils


# load the modules
sudo modprobe -a vboxdrv vboxnetadp vboxnetflt vboxpci


# add vboxdrv vboxnetadp vboxnetflt to the /etc/modules-load.d/virtualbox.conf file
vboxdrv
vboxnetadp 
vboxnetflt 
vboxpci


# start the virtualmachine from the command line
VBoxManage startvm qlproxy-amd64


