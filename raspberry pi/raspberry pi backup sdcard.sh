# raspberry pi backup sdcard

# plug in the sdcard and wait for it mount
# find the disk has been called by running the df -h command
df -h

# the disk should be labeled something like /dev/disk2s1
# you need to unmount the disk before you can copy it

# unmount the disk
diskutil unmountDisk /dev/disk2s1

# backup the sdcard wth dd
sudo dd bs=1m if=/dev/disk2s1 of=/Users/djwilcox/Desktop/rasbmc.img