#!/bin/bash

# luks encrypted container
#=========================

# create a 2 gig container wth dd on the desktop called crypt
cd ~/Desktop
dd if=/dev/urandom of=crypt bs=1M count=2048

# rename the file and give it a file extension to disguise it
mv crypt friday-the-13th.iso 

# find a free loop device to mount the file
sudo losetup -f

# the free loop device is /dev/loop0 in this case
# if you have a different free loop device use that number


# use the block device and the path to the file you just created
sudo losetup /dev/loop0 /home/$USER/Desktop/friday-the-13th.iso

# create the luks container inside the file
# you will be prompted to enter a password for the new luks container
sudo cryptsetup luksFormat /dev/loop0


# check the file is now an encrypted luks container
file /home/$USER/Desktop/friday-the-13th.iso


# map the luks container to the loop device
# and give it a luks alias in this case luks
sudo cryptsetup luksOpen /dev/loop0 luks

# format the container as ext4
sudo mkfs.ext4 /dev/mapper/luks

# mount the file
mkdir /tmp/luks
sudo mount /dev/mapper/luks /tmp/luks


# change ownership on container to the current user
cd /tmp/luks
sudo chown -R $USER:$USER .


# umount the file
sudo umount /tmp/luks

# close the luks container
sudo cryptsetup luksClose luks

# free the loop device
sudo losetup -d /dev/loop


# open luks encrypted container
#==============================

sudo losetup /dev/loop0 /path/to/crypt_file

sudo cryptsetup luksOpen /dev/loop0 luks

sudo mount /dev/mapper/luks /tmp/luks


# umount luks encrypted container
#================================

sudo umount /tmp/luks

sudo cryptsetup luksClose luks

sudo losetup -d /dev/loop0


# resize the container
#=====================

$ dd if=/dev/urandom bs=1M count=128 | cat - >> /path/to/crypt_file

sudo losetup /dev/loop0 /path/to/crypt_file

sudo cryptsetup luksOpen /dev/loop0 luks


# resize the encrypted container
sudo cryptsetup resize luks

# resize the filesystem

sudo e2fsck -f /dev/mapper/luks

sudo resize2fs /dev/mapper/luks


# mount the container
sudo mount /dev/mapper/luks /tmp/luks

# back up luks header
sudo cryptsetup luksHeaderBackup --header-backup-file /homevol_luksheader /dev/loop0

