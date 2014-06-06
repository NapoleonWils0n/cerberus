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
# and give it a luks alias in this case crypt_mount
sudo cryptsetup luksOpen /dev/loop0 crypt_mount

# format the container as ext4
sudo mkfs.ext4 /dev/mapper/crypt_mount

# mount the file
mkdir /tmp/crypt_mount
sudo mount /dev/mapper/crypt_mount /tmp/crypt_mount


# change ownership on container to the current user
cd /tmp/crypt_mount
sudo chown -R $USER:$USER .


# umount the file
sudo umount /tmp/crypt_mount

# close the luks container
sudo cryptsetup luksClose crypt_mount

# free the loop device
sudo losetup -d /dev/loop


# open luks encrypted container
#==============================

sudo losetup /dev/loop0 /path/to/crypt_data

sudo cryptsetup luksOpen /dev/loop0 raw_data

sudo mount /dev/mapper/raw_data /tmp/raw_data


# umount luks encrypted container
#================================

sudo umount /tmp/raw_data

sudo cryptsetup luksClose raw_data

sudo losetup -d /dev/loop0


# resize the container
#=====================

$ dd if=/dev/urandom bs=1M count=128 | cat - >> /path/to/crypt_data

sudo losetup /dev/loop0 /path/to/crypt_data

sudo cryptsetup luksOpen /dev/loop0 raw_data


# resize the encrypted container
sudo cryptsetup resize raw_data

# resize the filesystem

sudo e2fsck -f /dev/mapper/raw_data

sudo resize2fs /dev/mapper/raw_data


# mount the container
sudo mount /dev/mapper/raw_data /tmp/raw_data

# back up luks header
sudo cryptsetup luksHeaderBackup --header-backup-file /homevol_luksheader /dev/loop0

