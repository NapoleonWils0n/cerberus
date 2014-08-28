#!/bin/bash

# bittorent sync arch linux install
#==================================

# download the 64 bit version of btsync for linux

# untar the file
tar -zxvf btsync_x64.tar.gz

# remove the tar file
rm btsync_x64.tar.gz

# create the ~/bin directory
mkdir -p ~/bin

# move the btsync binary to your bin directory
mv btsync ~/bin

# make the binary executable
chmod u+x ~/bin/btsync

# create the ~/.btsync directory
mkdir -p ~/.btsync

# create the ~/.btsync/btsync.pid file
touch ~/.btsync/btsync.pid

# save the config file in the btsync ~/.btsync directory
btsync --dump-sample-config > ~/.btsync/btsync.conf

# edit the ~/.btsync/btsync.conf file
vim ~/.btsync/btsync.conf

# change the following sections and replace username with your username
# replace device-name with your choosen device-name

"device_name": "device-name",
"storage_path" : "/home/username/.btsync",
"pid_file" : "/home/username/.btsync/btsync.pid",


# edit your ~/.bashrc
vim ~/.bashrc

# add and alias so btsync starts up with the config file
alias btsync='btsync --config ~/.btsync/btsync.conf'


# source ~/.bashrc
. ~/.bashrc
