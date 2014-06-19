#!/bin/bash

# virtualbox install
#===================

# edit source.list
sudo vim /etc/apt/sources.list

# add virtualbox repo
deb http://download.virtualbox.org/virtualbox/debian trusty contrib

# add the key
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -

# install virtualbox
sudo apt-get install virtualbox-4.3

# add your user to the vboxusers group
# then log out and log back in
sudo usermod -a -G vboxusers username

# install dkms in virtualbox
sudo apt-get install dkms

# download extensions pack
wget http://download.virtualbox.org/virtualbox/4.3.12/Oracle_VM_VirtualBox_Extension_Pack-4.3.12-93733.vbox-extpack

# install guest additions from the virtualbox menu

# copy the VBoxLinuxAdditions.run to /root/
cp /media/cdrom/VBoxLinuxAdditions.run /root/

# make VBoxLinuxAdditions.run executable
cd /root/
chmod +x VBoxLinuxAdditions.run 

# now run the script
./VBoxLinuxAdditions.run 

# reboot and you should be able to go fullscreen
reboot


