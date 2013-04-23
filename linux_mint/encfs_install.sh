#!/bin/sh

# install encfs
sudo apt-get install encfs


# install gnome-encfs-manager 

# Add the following line to your /etc/apt/sources.list:
# deb http://ppa.launchpad.net/gencfsm/ppa/ubuntu precise main

# install
sudo apt-get update && sudo apt-get install gnome-encfs-manager

# add yourself ro the fuse group
sudo usermod -a -G fuse $USER


# create the encrypted directory
encfs ~/Dropbox/.encrypted ~/Private

# press p for paranoid mode
# then enter your password


# mount the encrypted directory from the command line
encfs ~/Dropbox/.encrypted ~/Private

# use gnome-encfs to mount the encrypted directory
gnome-encfs -a ~/Dropbox/.encrypted ~/Private


# back up the ~/Dropbox/.encrypted/.encfs6.xml file
~/Dropbox/.encrypted/.encfs6.xml ~/Documents/.encfs6.xml

# dropbox exclude the EncFS key .encfs6.xml file
# this will delete the .encfs6.xml file from the dropbox directory
dropbox exclude add ~/Dropbox/.encrypted/.encfs6.xml

# copy the .encfs6.xml back to ~/Dropbox/.encrypted/.encfs6.xml
cp ~/Documents/.encfs6.xml ~/Dropbox/.encrypted/.encfs6.xml

# Open the Dropbox site and delete the .encrypted/.encfs6.xml file

