#!/bin/bash


# raspberry pi install arch linux using noobs installer
#=======================================================



# set up noobs
#===========================================#

# download noobs installer from raspberypi.org

# format sdcard

# unzip noobs.zip

# copy contents of older to root of sdcard, 
# not the folder itself

# connect pi up to tv and boot up


# inital set up
#===========================================#

# set hostname
nano /etc/hostname

# update hosts file
nano /etc/hosts

# pacman
pacman-key –init


# We need to create random entropy
# to help this process along, open a new terminal window with ALT+F2 and enter the following :
ls -R / && ls -R / && ls -R /


# You might have to do this a few times,
# keep switching back to the first console with ALT+F1 to check if it has generated a key yet, 
# when it has we can update using this command 

# update pacman
pacman -Syu

# reboot
reboot


#===========================================#

# upgrade pacman database
pacman-db-upgrade


# create user
#===========================================#


# add user
useradd -m -g users -G audio,lp,optical,wheel,storage,power,video -s /bin/bash username

# add password for user
passwd username

# install sudo

#===========================================#

# install sudo 
pacman -S sudo


# edit sudoers file
visudo

# add your user to the /etc/sudoers file
%username ALL=(ALL) ALL



#===========================================#

##

## User privilege specification

##

and uncomment the line below to say :

%wheel ALL=(ALL) ALL

Save and exit in the normal way.

Locate the lines that are currently commented out as follows :

## Uncomment to allow members of group sudo to execute any command

# %sudo ALL=(ALL) NOPASSWD: ALL

Uncomment the second of the above lines, so that it reads as follows :

## Uncomment to allow members of group sudo to execute any command

%sudo ALL=(ALL) NOPASSWD: ALL 



# copy ssh keys
#===========================================#


ssh-copy-id username@192.168.1.9


# ssh config


# raspberry pi
Host pi
User username
Port 22
HostName 192.168.1.9

ssh pi


# i love candy
#===========================================#

sudo nano /etc/pacman.conf

ILoveCandy



# yaourt
#===========================================#


sudo pacman -S base-devel bash-completion \
rsync sed grep gzip less nano wget which whois tar


4 - create a builds directory

mkdir -p ~/builds

# change directory to the ~/builds directory

cd ~/builds


#===================================

# download package query
curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz

# untar the file
tar zxvf package-query.tar.gz

# Enter the folder containing the PKGBUILD
cd package-query

# install the package
makepkg -si


#===================================

# change directory before reinstalling yaourt

cd ~/builds

#===================================

5 - reinstall yaourt

# download yaourt
curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz

# untar the file
tar zxvf yaourt.tar.gz

# Enter the folder containing the PKGBUILD
cd yaourt

# install the package
makepkg -si


#===================================

# update pacman
sudo pacman -Syu

# update yaourt
yaourt -Syua


#===================================

Edit your ~/.gnupg/gpg.conf and uncomment the following line:
keyserver-options auto-key-retrieve


# gcc-libs
#===================================

sudo pacman -S gcc-libs


# mplayer
#===================================

sudo pacman -S mplayer


# install vlc which will install ffmpeg
#==========================================

sudo pacman -S vlc libdvdcss 


# mpv
#===================================

sudo pacman -S mpv


# general 
#===================================

imagemagick  nodejs



# smbclient
#===================================

sudo pacman -S smbclient


# create a mount point
mkdir -p /home/username/mount



# mount smb share
#===================


# mount smb share as read write

sudo mount -t cifs //192.168.1.25/video/Downloads/ffmpeg /home/username/mount -o user=username,workgroup=workgroup,rw


sudo mount -t cifs //192.168.1.25/video/Downloads /home/djwilcox/mount -o user=djwilcox,workgroup=workgroup,uid=djwilcox,gid=users,rw



# fstab smb share
#===================

# create sambacreds file and add username and password, instead of hardcoding into fstab


vim /home/djwilcox/documents/sambacreds

username=username
password=password


# change permissions on the sambacreds file

sudo chmod 600 /home/djwilcox/documents/sambacreds



# edit fstab and add smb share

sudo su
vim /etc/fstab

//192.168.1.25/video/Downloads /home/djwilcox/mount cifs credentials=/home/djwilcox/documents/sambacreds,comment=systemd.automount,workgroup=workgroup,rw,uid=djwilcox,gid=users, 0 0



# unmount smb share
#===================

sudo umount /home/username/mount


