#!/bin/bash

 # =====================================
 # = sshfs mount ssh server on desktop =
 # =====================================


sudo apt-get install sshfs


# open user and groups on ubuntu
# 
# click the lock icon and enter your password
# 
# select the groups button and then click the fuse group
# 
# in the next window put a tick in the checkbox next to your user account


# Make a directory in your home folder as a mount point

mkdir Server

chmod 700 Server


# Mounting the ssh server


sshfs user@192.168.1.2:/Users/$USER/Subversion Server/


Unmounting ssh server

fusermount -u Server/

