#!/bin/bash

# arch linux lvm on luks -  efi boot on macbook air
#==========================================================================================#



# back up mac firware
#==========================================================================================#

# If you are not going to have OS X installed, make backups of these files:
/System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBVideoSupport.kext/Contents/MacOS/AppleUSBVideoSupport

# You will need this file later for iSight functionality.
/Library/ColorSync/Profiles/Displays/<FILES HERE>




# plug in a usb drive to your mac
#==========================================================================================#

# find out where its mounted
diskutil list

# it should be something like disk2
# check by unmounting the drive
diskutil unmountDisk /dev/disk2

# if the drive is ejected you know you have the right drive number
# unplug the drive and plug it back in again so it mounts



# create a bootable usb of arch linux
#==========================================================================================#

# download the latest arch iso 

# Convert the .iso file to .img using the convert option of hdiutil 
hdiutil convert -format UDRW -o ~/Desktop/arch.img ~/Desktop/archlinux-2014.06.01-dual.iso

# remove the .dmg extension from the file
mv arch.img.dmg arch.img

# copy the img to the usb drive
sudo dd if=~/Desktop/arch.img of=/dev/rdisk2 bs=1m

# After the dd command finishes, eject the drive:
diskutil eject /dev/rdisk2




# erase and format the mac internal drive and partition
#==========================================================================================#

# boot up into external usb clone of your macs internal drive

# open disk utility 

# you should also see your macs internal drive in the left hand sidebar which doesnt have a coloured icon

# select the top level of your macs internal drive, not the drive underneath and slightly indented to the right

# now select the erase tab, and make sure Mac Osx extended (Journaled) is selected, then click erase

# this will erase the whole drive and create a GUID_partition_scheme on disk0

# it will also create a 200 MB EFI partition at disk0s1

# it will also create a hfs partition at disk0s2

# select the drive underneath and slightly indented to the right of the drive you just formatted 

# click on the erase tab and from the drop down select MS-DOS (FAT), then click erase

# this will erase disk0s2 and format it as FAT, it wont erase the GUID_partition_scheme or the EFI partition on disk0s1



# show the disk layout and you should see something like the following
diskutil list

# /dev/disk0
#   #:                       TYPE NAME                    SIZE       IDENTIFIER
#   0:      GUID_partition_scheme                        *121.3 GB   disk0
#   1:                        EFI EFI                     209.7 MB   disk0s1
#   2:       Microsoft Basic Data LINUX                   121.0 GB   disk0s2


# after you have erased the macs internal drive quit disk utility

# and then shut down the mac and unplug the external usb drive that you have boot up from





# boot into arch linux
#==========================================================================================#

# plug in your usb to ethernet adaptor and connect it to your router

# shutdown you mac, plug in your usb stick and press the power button and then the alt key
# select the drive marked windows and press return




# check you have booted the usb stick in efi mode
#==========================================================================================#
efivar -l




# list the keyboard layout keymaps
#==========================================================================================#


# list the keyboard layout keymaps
ls /usr/share/kbd/keymaps/mac

# loadkeys
cd /usr/share/kbd/keymaps/mac
loadkeys gb




# partition the drive
#==========================================================================================#

# list the drives
lsblk -f


# use cgdisk to create the partitions
cgdisk

# select /dev/sda2

# partition /dev/sda2 into 2 new partitions, 
# one for the linux boot directory and the other for the luks encrypted partition


# /dev/sda2 256 MB boot ext2
# /dev/sda3 ext4 for the luks lvm 


# set the bootable flag on /dev/sda2 boot partition
fdisk /dev/sda2

# add the bootbale flag by press a
a

# then write the changes and quit
w


# use fsprobe to inform the kernal about the partition changes
partprobe -s /dev/sda


# format the /dev/sda2 boot partition as ext2
mkfs.ext2 /dev/sda2



# luks lvm container
#==========================================================================================#

# list drive partitions
lsblk

# Load the kernel module for encryption:
modprobe dm-crypt

# Encrypt the big partition (sda3)
cryptsetup --cipher aes-xts-plain64 --hash sha512 --verify-passphrase --key-size 512 luksFormat /dev/sda3

# check our lvm
cryptsetup luksDump /dev/sda3

# And open it, so it will be in /dev/mapper/lvm:
cryptsetup luksOpen /dev/sda3 lvm

# luksClose
# cryptsetup luksClose /dev/sda3 


# Create a physical volume, volume group, logical volumes 
#==========================================================================================#

# create a physical volume
pvcreate /dev/mapper/lvm
pvdisplay

# create a volume group
vgcreate main /dev/mapper/lvm
vgdisplay

# create the logical volumes
lvcreate -L 30GB -n root main
lvcreate -L 4GB -n swap main
lvcreate -l 100%FREE -n home main
lvdisplay


# create a ext4 file system on /root and /home
mkfs.ext4 /dev/mapper/main-root
mkfs.ext4 /dev/mapper/main-home

# create the swap file
mkswap /dev/mapper/main-swap
swapon /dev/mapper/main-swap


# Mount volumes, install Arch Linux
#==========================================================================================#


# Mount the volumes into the running livesystem:

# mount the root file system to /mnt
mount /dev/mapper/main-root /mnt

mkdir /mnt/boot
mount /dev/sda2 /mnt/boot

mkdir /mnt/home
mount /dev/mapper/main-home /mnt/home



# start lvmetad before chroot into system
#==========================================================================================#

# Use the following command to activate the the lvm service for systemd:
systemctl start lvm2-lvmetad


# choose mirror
#==========================================================================================#
nano /etc/pacman.d/mirrorlist


# Scroll down to your preferred mirror (the closer to your location the better), 
# press Alt+6 to copy the line, then scroll back up and press Ctrl+U to paste that line at the top of the list. 
# US users should already have a good server at the top of the list. 
# When you're done, press Ctrl+X to exit, and save with Y and Enter if you made any changes.


# update repositories
pacman -Sy



# Install base system
#==========================================================================================#

pacstrap -i /mnt base base-devel


# Generate fstab:
#==========================================================================================#

genfstab -p -U /mnt > /mnt/etc/fstab


# cChroot and configure the base system
#==========================================================================================#

arch-chroot /mnt /bin/bash 



# install the dosfstools package, so you can manipulate your EFI System Partition after installation:
#==========================================================================================#

pacman -S dosfstools efibootmgr




# Configuring the boot loader
#==========================================================================================#


# Boot init order
nano /etc/mkinitcpio.conf

# Put “keymap”, “encrypt” and “lvm2″ (in that order!) before “filesystems” in the HOOKS array.
HOOKS="... keymap encrypt lvm2 ... filesystems ..."

# Find MODULES 

# uncomment « MODULES= » and add « dm_mod ext4″


# The keymap hook is only necessary if you changed the keyboard layout prior to the creation of the encrypted partition. 
# The encrypt hook has to be loaded before the lvm2 hook! After that we can create the new ramdisk with

# After that we can create the new ramdisk with
mkinitcpio -p linux


# ignore these errors
# ==> WARNING: Possibly missing firmware for module: aic94xx
# ==> WARNING: Possibly missing firmware for module: bfa


# install grub
#==========================================================================================#

# Install grub

pacman -S grub-efi-x86_64


# fix broken grub.cfg gen
#==========================================================================================#

nano /etc/default/grub

# fix broken grub.cfg gen
GRUB_DISABLE_SUBMENU=y



# Then, before installing grub you have to change the file /boot/grub/menu.lst at two points:
# Add "cryptdevice=/dev/sda2:vgroup" between "root=..." and "ro" in the paragraphs "Arch Linux" and "Arch Linux Fallback

# find the GRUB_CMDLINE_LINUX_DEFAULT variable line, and change it to look like this:
GRUB_CMDLINE_LINUX_DEFAULT="quiet cryptdevice=/dev/sda3:main rootflags=data=writeback"


# also change the Arch Linux Fallback lines as well



#==========================================================================================#

# Make a directory named efi in /boot

# Mount the already-existing EFI partition on your Mac to this /boot/efi directory

# Install GRUB to this directory

# Make a directory named locale in /boot/grub

# Copy grub.mo from /usr/share/locale/en\@quot/LC_MESSAGES/ to /boot/grub/locale

# Generate a configuration for GRUB

# Done! GRUB will now start on reboot and you can boot into your newly installed Archlinux.

# Remember to hold ALT/Option key while starting your computer if you want to boot back into Mac OS X

# Finish the standard Arch install procedures, making sure that you install grub and partition your boot hard disk as GPT.


# The UEFI system partition will need to be mounted at /boot/efi/ for the GRUB install script to detect it:

mkdir -p /boot/efi

mount -t vfat /dev/sdXY /boot/efi

# eg
mount -t vfat /dev/sda1 /boot/efi

# Where X is your boot hard disk and Y is the efi partition you created earlier.


# Install GRUB UEFI application to and its modules to /boot/grub/x86_64-efi using:


modprobe dm-mod

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck --debug

mkdir -p /boot/grub/locale

cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo



# Generate a configuration for GRUB
#==========================================================================================#

grub-mkconfig -o /boot/grub/grub.cfg




# copy the efi grub
#==========================================================================================#

cp /boot/efi/EFI/arch_grub/grubx64.efi /boot/efi/EFI/boot/grubx64.efi



# Configure the network
#==========================================================================================#


# identify the network interfaces
ip link

# enable dhcp
systemctl enable dhcpcd.service
systemctl start dhcpcd.service

systemctl enable dhcpcd@interface_name.service
systemctl enable dhcpcd@eth0.service

# bring up the eth0 network interface
ip link set eth0 up

# use dhcp to get an ip address
dhcpcd eth0


# check if your ethernet connection works, change interface to wlan0 if using wifi
ping -I eth0 -c 3 www.google.com




# list the keyboard layout keymaps
#==========================================================================================#


# list the keyboard layout keymaps
ls /usr/share/kbd/keymaps/mac

# loadkeys
cd /usr/share/kbd/keymaps/mac
loadkeys gb



# set up locale
#==========================================================================================#

# edit /etc/locale.gen
nano /etc/locale.gen

# delete the # in front of your language of choice 
en_US.UTF-8 UTF-8

# generate the locale
locale-gen

# Create the /etc/locale.conf file substituting your chosen locale:
echo LANG=en_US.UTF-8 > /etc/locale.conf

# Export substituting your chosen locale:
export LANG=en_US.UTF-8


# Console font and keymap
#==========================================================================================#

# If you changed the default console keymap and font in #Change the language, 
# you will have to edit /etc/vconsole.conf accordingly 
# (create it if it does not exist) to make those changes persist in the installed system, for example:


nano /etc/vconsole.conf

KEYMAP=de-latin1
FONT=lat9w-16


# set up the timezone
#==========================================================================================#


# set the timezone
ls /usr/share/zoneinfo/

# create a symbolic link to your time zone 
ln -s /usr/share/zoneinfo/<Zone>/<SubZone> /etc/localtime

# set the timezone change to london uk
ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime


# set the clock according to your chosen zone 
hwclock --systohc --utc


# Define yout hostname:
#==========================================================================================#


# echo hostname > /etc/hostname
# echo blackbird > /etc/hostname


# set hostname, replace hostname with your hostname
hostnamectl set-hostname hostname

# eg
hostnamectl set-hostname blackbird



# Add the same hostname to /etc/hosts:
# replace myhostname with your hostname
nano /etc/hosts


#
# /etc/hosts: static lookup table for host names
#

#<ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1	localhost.localdomain	localhost	myhostname
::1		localhost.localdomain	localhost

# End of file



# set the root password 
#==========================================================================================#

passwd


# add the new user
#==========================================================================================#

# add user
useradd -m -g users -G wheel,storage,power -s /bin/bash djwilcox

# set the user password
passwd djwilcox


# enter password and verify


# install sudo 
#==========================================================================================#

sudo pacman -S sudo

# pacman -Ss sudo

# set nano as the editor for visudo
EDITOR=nano visudo


# add your user to the /etc/sudoers file

# replace username with your username
%username ALL=(ALL) ALL

# eg
%djwilcox ALL=(ALL) ALL




# exit the chroot
#==========================================================================================#

exit


# unmount the drives
umount /mnt
umount /mnt/boot
umount /mnt/home

swapoff
reboot


# Xorg
#==========================================================================================#


# To see which graphics card you have type:
lspci | grep VGA


# install xorg driver
sudo pacman -S xorg-server xorg-xinit xorg-server-utils xf86-video-intel xf86-input-synaptics 
mesa xfce4 xfce4-goodies gamin 

# font
ttf-deja
 
# samba
samba smbclient gvfs gvfs-smb sshfs

# network manager
networkmanager networkmanager-applet


# xinitrc
#==========================================================================================#

cp /etc/skel/.xinitrc ~/.xinitrc

nano ~/.xinitrc
# uncomment exec startxfce4


# startx
startx



# wifi
#==========================================================================================#

pacman -S wireless_tools wpa_supplicant wpa_actiond dialog


# connect to your wifi network
wifi-menu



# install networkmanager
#==========================================================================================#


# Now we’re going to disable the normal dhcpcd service and install probably the easiest to use Network Manager.

pacman -S networkmanager network-manager-applet gnome-keyring seahorse

systemctl stop dhcpcd@wlan0
systemctl stop dhcpcd@eth0

systemctl disable dhcpcd@wlan0
systemctl disable dhcpcd@eth0


# Bring both your ip links down and back up with:


ip link set eth0 down
ip link set wlan0 down

ip link set eth0 up
ip link set wlan0 up


# You’ll be using the gnome-keyring to save your wifi passwords and since you don’t want the rest of the GNOME desktop, 
# add this to your ~/.xinitrc file


# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID



# Now you just need to enable NetworkManager dameons and start the nm-applet
systemctl enable NetworkManager
systemctl start NetworkManager

nm-applet


# sound
#==========================================================================================#

pacman -S alsa-utils


# log in as your account not root and then run alsamixer
# unmute the volume
alsamixer


# install bash completion
#==========================================================================================#

pacman -S bash-completion


# xfce4 terminal
#==========================================================================================#
pacman -S xfce4-terminal



# Configure repositories
#==========================================================================================#
nano /etc/pacman.conf

# If you are using 64 bit system you should go ahead and enable (un-comment) the “multilib” repo:
[multilib]
Include = /etc/pacman.d/mirrorlist

# update the repositories
pacman -Sy

