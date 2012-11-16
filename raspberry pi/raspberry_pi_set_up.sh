#!/bin/sh

#----------------------------------------------------------------------------------------#
#	raspberry pi set up  #
#----------------------------------------------------------------------------------------#

# list the hard drives

df -h


# mac drive

# /dev/disk1     112Gi   92Gi   20Gi    83%    /


# insert the sd card and run df -h again and you should see a new drive

# sd card
# /dev/disk2s1   7.4Gi  1.7Mi  7.4Gi     1%    /Volumes/NO NAME


# Unmount the partition so that you will be allowed to overwrite the disk:

diskutil unmount /dev/disk2s1


# Using the device name of the partition work out the raw device name for the entire disk,
# by omitting the final "s1" and replacing "disk" with "rdisk":

# e.g. /dev/disk2s1 => /dev/rdisk2


# In the terminal write the image to the card with this command, using the raw disk device name from above:

sudo dd bs=1m if=~/Downloads/debian6-19-04-2012/debian6-19-04-2012.img of=/dev/rdisk2


# After the dd command finishes, eject the card:
diskutil eject /dev/rdisk2

