#!/bin/bash

 # =========================
 # = Backtrack Mac install =
 # =========================


# Partition hard drive with bootcamp
# 
# Make a 20 gig boot camp partition.
# 
# 
# Download and install rEFIt from sourceforge
# 
# Double click the shell script to bless the bootloader
# 
# 
# Insert the Backtrack DVD and reboot the mac, then select the dvd on the refit screen
# 
# 
# Once Backtrack has loaded log in with these details
# 
# username: root
# 
# password: toor
# 
# 
# 
# Start the x window with this command

startx



# list the hard drive partitions with this command

fdisk -l


# Partition the hard drive this is the layout before the install
# 
# /dev/sda1  - bootloader
# 
# /dev/sda2  - Mac OSX
# 
# /dev/sda3 -  Bootcamp



# Install Backtrack on /dev/sda3 with this command


fdisk /dev/sda

# press p - to select a partition
# 
# press t
# 
# press 3 - to select the third partition
# 
# type 82 - to format the partition as linux
# 
# type w - to write out the partition table
# 
# Format /dev/sda3 as reiserfs by entering this command

first umount the drive


umount /dev/sda3

mkreiserfs /dev/sda3



# Create the mount point

mkdir /mnt/bt 

mount /dev/sda3 /mnt/bt/

mkdir /mnt/bt/boot 


cp --preserve  -R /{bin,dev,home,pentest,root,usr,etc,lib,opt,sbin,var} /mnt/bt/

mkdir /mnt/bt/{mnt,tmp,proc,sys} 

mount -t proc proc /mnt/bt/proc 

mount --bind /dev/ /mnt/bt/dev/

cp -R /boot/* /mnt/bt/boot/

chroot /mnt/bt/ /bin/bash



# edited the lilo file

nano /etc/lilo.conf

# it should look like this


# boot=/dev/sda
# root=/dev/sda3

# bitmap=/boot/sarge.bmp
# bmp-colors=1,,0,2,,0
# bmp-table=120p,173p,1,15,17
# bmp-timer=254p,432p,1,0,0
# install=bmp

# delay=20

# prompt
# timeout=50

# map=/boot/map

# vga=0x317
# 
# image=/boot/vmlinuz
#   label="BT4"
#   read-only
#   initrd=/boot/splash.initrd
#   append=quiet
	
	


# Fix kismet

nano /etc/kismet/kismet.conf

# Find the line:

source=none,none,addone

# and replace it with:

source=madwifi_g,wifi0,madwifi


# it should look like this


# YOU MUST CHANGE THIS TO BE THE SOURCE YOU WANT TO USE
source=madwifi_g,wifi0,madwifi
#source=iwl3945,wlan0,intel




# Now we are ready to execute lilo.

lilo -v


# then reboot by typing this command

reboot


# After install
# 
# Change the default password with this command

passwd


# Fix the problem with the real time clock (/dev/rtc) and aircrack
# 
# type this in the terminal

modprobe rtc-cmos



