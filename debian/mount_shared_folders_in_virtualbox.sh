#!/bin/bash

# create a shared folder in VirtualBox settings

# create a mount point
mkdir ~/mnt

# switch to root
su

# mount the shared folder
mount -t vboxsf Desktop /home/$USER/mnt

# unmount the shared folder
umount -t vboxsf Desktop /home/$USER/mnt
