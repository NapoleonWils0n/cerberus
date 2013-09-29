#!/bin/bash

# bittorent sync linux install
#=============================

# download the 64 bit version of btsync for linux

# untar the file
tar -zxvf btsync_x64.tar.gz

# remove the tar file
rm btsync_x64.tar.gz

# move the btsync binary to your bin directory
mv btsync ~/bin

# make the binary executable
chmod +x ~/bin/btsync

# save the config file in the btsync ~/.sync directory
btsync --dump-sample-config > ~/.sync

# edit your ~/.bashrc
vim ~/.bashrc

# add and alias so btsync starts up with the config file
alias btsync='btsync --config ~/.sync'
