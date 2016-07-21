#!/bin/bash

sudo cryptsetup -y luksAddKey ENCRYPTED_PARTITION
sudo cryptsetup luksRemoveKey ENCRYPTED_PARTITION

# find the luks partition
less /etc/crypttab

# add new key
sudo cryptsetup -y luksAddKey /dev/sda3

# remove old key
sudo cryptsetup luksRemoveKey /dev/sda3




