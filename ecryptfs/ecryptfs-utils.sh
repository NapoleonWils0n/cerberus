#!/bin/bash

# ecryptfs-utils encrypt files on Dropbox
#========================================

# install ecryptfs-utils
sudo pacman -S ecryptfs-utils

# load the ecryptfs module
sudo modprobe ecryptfs

# create the directories for ecryptfs
#====================================

mkdir -p ~/Dropbox/.logs ~/.private ~/.ecryptfs
touch ~/.ecryptfs/dropbox.conf ~/.ecryptfs/dropbox.sig

# ~/Dropbox/.logs will be hold the encrypted data
# ~/Private will be the mount point
# ~/.ecryptfs is the ecryptfs directory

# add the filepaths to the ~/.encryptfs/secret.conf
echo "/home/username/Dropbox/.logs /home/username/.private ecryptfs" > ~/.ecryptfs/dropbox.conf


# add the passphrase
#===================

ecryptfs-add-passphrase

# Write the output signature (ecryptfs_sig) from the previous command to ~/.ecryptfs/dropbox.sig
# replace 78c6f0645fe62da0 with the output signature
echo 78c6f0645fe62da0 > ~/.ecryptfs/dropbox.sig


# add the signature passphrase to your keychain
# add the mount-passphrase at the first password prompt
# and then your user login password at the second password prompt
ecryptfs-wrap-passphrase ~/.ecryptfs/dropbox-wrapped-passphrase

# add the wrapped-passphrase to the keychain
# add your login password at the prompt
ecryptfs-insert-wrapped-passphrase-into-keyring /home/username/.ecryptfs/dropbox-wrapped-passphrase


# mount and umount ecryptfs
#==========================

# mount 
mount.ecryptfs_private dropbox

# unmount 
umount.ecryptfs_private dropbox
