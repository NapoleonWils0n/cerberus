#!/bin/sh

# sshfs Raspberry Pi

# install sshfs
sudo apt-get install sshfs

# Then add the user pi to the FUSE users group:
sudo gpasswd -a pi fuse

# create the mount point
mkdir ~/mount

# connect and mount via sshfs
# The idmap=user option ensures that files owned by the remote user are owned by the local user.
sshfs -p 55724 -o idmap=user username@92.40.255.60:/storage/emulated/legacy/Download /home/pi/mount 


# defaults,idmap=user,noauto,user 0 0
sshfs user@80.0.0.0:/home/username /Users/username/mnt -o idmap=user,auto_cache,reconnect,volname=sshfs


# unmount sshfs on linux
fusermount -u ~/mount

# unmount sshfs on mac osx
umount ~/mnt

