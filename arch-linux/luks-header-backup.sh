#!/bin/bash

# where <device> is the partition containing the LUKS volume.

sudo cryptsetup luksHeaderBackup /dev/<device> --header-backup-file /mnt/<backup>/<file>.img

sudo cryptsetup luksHeaderBackup /dev/sda3 --header-backup-file /home/djwilcox/Desktop/luks-header.img
