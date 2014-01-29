#!/bin/bash

# virtualbox install
sudo apt-get install virtualbox-nonfree

# add your user to the vboxusers group
# then log out and log back in
sudo usermod -a -G vboxusers username

# then download and install the VirtualBox 4.2.12 Oracle VM VirtualBox Extension Pack
# https://www.virtualbox.org/wiki/Downloads
# double click the download file to install the extension pack

# in the guest download the latest guest additions
# http://download.virtualbox.org/virtualbox/4.2.12/VBoxGuestAdditions_4.2.12.iso

# mount the iso
mount VBoxGuestAdditions_4.2.12.iso /media/cdrom

# copy the VBoxLinuxAdditions.run to /root/
cp /media/cdrom/VBoxLinuxAdditions.run /root/

# make VBoxLinuxAdditions.run executable
cd /root/
chmod +x VBoxLinuxAdditions.run 

# now run the script
./VBoxLinuxAdditions.run 

# reboot and you should be able to go fullscreen
reboot
