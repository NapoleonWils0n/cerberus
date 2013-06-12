#!/bin/bash


# if you mess up your /etc/fstab and cant boot up, heres how to fix it

# if you get an error while booting that says it cant mount the filesystem
# press m to manually fix it

# then select boot into recovery mode
# then select root terminal

# check which disk has the root file system on it
fdsik -l


# if the root file system is on /dev/sdb and formatted as ext 4
# run the follwoing command

# mount filesystem as writeable
mount -n -o remount -t ext4 /dev/sdb/ /

# you can now edit /etc/fstab or replace your back up

# edit fstab
# nano /etc/fstab

# replace backup fstab

# rename /etc/fstab /etc/fstab.backup2
# mv /etc/fstab /etc/fstab.backup2

# rename /etc/fstab.backup /etc/fstab
# mv /etc/fstab.backup /etc/fstab

# reboot