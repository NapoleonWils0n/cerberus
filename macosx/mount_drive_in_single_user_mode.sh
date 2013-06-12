#!/bin/bash

#-----------------------------------------------#
# mount usb drive in single user mode
#-----------------------------------------------#


# reboot the mac and press s to start up in single user mode

# mount the internal mac drive
/sbin/mount -uw /

# list the volumes
ls /Volumes

# create a mount point directory in /Volumes
mkdir /Volumes/drive/$USER

# list the drives, the last drive listed should be the external usb drive
ls /dev/disk*

# check the drives partition type eg hfs
fstyp /dev/disk1s2

# mount the external drive on the mount point
mount –t hfs /dev/disk1s2 /Volumes/drive

# copy files from the internal drive to the external drive
cd /Users/$USER

cp -rp /Users/$USER/Sites /Volumes/drive/$USER

# -r = recurcive
# p = Cause cp to preserve the following attributes of each source file in the copy:
# modification time, access time, file flags, file mode, user ID, and group ID,
# as allowed by permissions.  Access Control Lists (ACLs) and Extended Attributes
# (EAs), including resource forks, will also be preserved.