#!/bin/bash

# luks encrypted container
#=========================

# create a container 
dd if=/dev/urandom of=crypt bs=1M count=2048

# find a free loop device to mount the file
sudo losetup -f

# use the block device
sudo losetup /dev/loop0 /home/djwilcox/Desktop/crypt

# create the luks container inside the file
sudo cryptsetup luksFormat /dev/loop0

# check the file
file /home/djwilcox/Desktop/crypt

# map the luks container
sudo cryptsetup luksOpen /dev/loop0 crypt_mount

# format the container as ext4
sudo mkfs.ext4 /dev/mapper/crypt_mount

# mount the file
mkdir /tmp/crypt_mount

sudo mount /dev/mapper/crypt_mount /tmp/crypt_mount


# change ownership on container
sudo chown -R $USER .


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

