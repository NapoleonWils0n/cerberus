#!/bin/bash

# raspberry pi - nas - sabnzbd - sickbeard - couchpotato
#========================================================

# plugin the sdcard to your sdcard reader and plug in to your usb port

# find the sdcards device name with df or fdisk
df -h

sudo fdisk -l 


# umount the sdcard
umount /dev/sdb

# copy the disk image to the sdcard
sudo dd bs=1m if=~/Downloads/debian6-19-04-2012.img of=/dev/sdb


# find the pi on the network and ssh in
#======================================


# install avahi-daemon
#=====================

sudo apt-get install avahi-daemon
sudo update-rc.d avahi-daemon defaults


# set up avahi to advertise ssh services
#=======================================

# we can also add the ssh service to be explicitly announced by avahi-daemon,
# by adding a new file /etc/avahi/services/ssh.service

<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h SSH</name>
  <service>
    <type>_ssh._tcp</type>
    <port>22</port>
  </service>
</service-group>


# restart the avahi daemon
sudo /etc/init.d/avahi-daemon restart


# shorten raspberry pi hostname
#==============================

# edit the hosts file
sudo nano /etc/hosts

# change the hostname to pi
pi


# edit the /etc/hostname file
sudo nano /etc/hostname

# change the hostname to pi
pi

sudo /etc/init.d/hostname.sh

sudo reboot



# you should now be able to ssh into the pi with the shortened hostname and with a .local address
#================================================================================================
ssh pi@pi.local


# set your linux laptop to save ssh key passwords in the gnome keyring
#======================================================================

# Set up GnomeKeyring in XFce goto Settings-Session and Startup-Advanced 
# select Launch GNOME services on startup and it saved the identity to the keyring.



# format an external usb drive as ext4 
#=====================================

# find the drive number
df -h

# format the usb drive as ext4
sudo mkfs.ext4 /dev/sdb1 -L pi

# mount the drive
sudo mount -t auto /dev/sda1 /media/usbdrive

# edit the fstab
sudo nano /etc/fstab

# add an entry for the usb drive so it mounts on boot
/dev/sda1 /media/usbdrive auto noatime 0 0


# create a new user account on the pi with same permissons as the pi account
#===========================================================================

# switch to root
sudo su

# create a new user with the same name as the user account as your linux laptop
adduser djwilcox 

# add the new user to the same groups as the pi account
usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,netdev,input,indiecity djwilcox

# edit the sudoers file
visudo

# add the new user to the sudoers file, so you can use sudo
djwilcox  ALL=(ALL) ALL



# copy your ssh keys from your laptop to the new account on the pi
#=================================================================

ssh-copy-id djwilcox@pi.local

# you should now be able to ssh into the pi using ssh keys
ssh djwilcox@pi.local

# change permissions on the drive so both pi and new user djwilcox have write access
#===================================================================================

sudo chown -R djwilcox:djwilcox /media/usbdrive
sudo chmod -R 777 /media/usbdrive


# secure ssh to only allow ssh keys 
#==================================

# no root log in via ssh, no password logins only ssh keys

sudo nano /etc/ssh/sshd_config

PermitRootLogin no
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no


# set up samba sharing
#=====================

# install samba for smb sharing
sudo apt-get install samba samba-common-bin

# backup config file
sudo cp /etc/samba/smb.conf{,.backup}

# edit the smb.conf file
sudo nano /etc/samba/smb.conf

# under authentication, uncomment security = user
   security = user


# add the following code to the bottom of the /etc/samba/smb.conf file
[Pi]
comment = Pi drive
path = /media/usbdrive
valid users = @users
force group = users
create mask = 0660
directory mask = 0771
read only = no


# restart samba
sudo /etc/init.d/samba restart

# add existing user to smb
sudo smbpasswd -a djwilcox



# install sabnzbd
#================

sudo apt-get install sabnzbdplus

# start the sabnzbdplus server
sabnzbdplus --server 0.0.0.0

# go to the sabnzbd wizard in your browser
http://pi.local:8080/sabnzbd/wizard/

# after you have finished the wizard you can connect to sabnzbd on this address
http://pi.local:8080/sabnzbd/


# install unrar-nonfree to unrar files
#=====================================

# edit /etc/apt/sources.list
sudo nano /etc/apt/sources.list


# add the following line to /etc/apt/sources.list
deb-src http://archive.raspbian.org/raspbian wheezy main contrib non-free rpi

# run sudo apt-get update
sudo apt-get update

# create a directory for the unrar source
mkdir ~/unrar-nonfree && cd ~/unrar-nonfree

# build unrar
sudo apt-get build-dep unrar-nonfree
sudo apt-get source -b unrar-nonfree
sudo dpkg -i unrar_4.1.4-1_armhf.deb

# cd up a directory
cd ../ 

# switch to root
sudo su

# remove the unrar-nonfree directory
rm -rf unrar-nonfree



# create the sabnzbd directories on your usb drive
#=================================================

mkdir -p /media/usbdrive/sabnzbd/downloading
mkdir -p /media/usbdrive/sabnzbd/complete
mkdir -p /media/usbdrive/sabnzbd/watch
mkdir -p /media/usbdrive/sabnzbd/nzb-backup
mkdir -p /media/usbdrive/sabnzbd/scripts


# After creating the directories, return to the WebUI of SABnzbd to change the default directories. In the WebUI, navigate to Config -> Folders. There are two sections, User Folders and System folders. Within those two sections, change the following entries using the folders we just created. You must use absolute paths to force SABnzbd to use folders outside the default of /home/pi/.



# install sickbeard
#==================

sudo apt-get install git-core
sudo apt-get install python-cheetah

# download sickbeard
git clone git://github.com/midgetspy/Sick-Beard.git sickbeard

# move sickbeard to ~/.sickbeard
mv sickbeard ~/.sickbeard

# move the startup script into place
sudo mv ~/.sickbeard/init.ubuntu /etc/init.d/sickbeard

# edit the startup script and set some options

sudo vim /etc/init.d/sickbeard

# Edit the APP_PATH to point to /home/user/.sickbeard, 
# where "user" is your username and set RUN_AS to your username,
# your file should then look something like this:

# replace "username" with your username
RUN_AS=${SB_USER-username}

# replace "username" with your username
APP_PATH=/home/username/.sickbeard

# edit /etc/defaults/sickbeard
sudo vim /etc/defaults/sickbeard

# add SB_USER=username to /etc/default/sickbeard
# replace "username" with your username
SB_USER=username

# if you want sickbeard to run on boot run the following command
sudo update-rc.d sickbeard defaults

# start sickbeard
sudo service sickbeard start

# if you get an error that sickbeard cant write the pid file
# you need to delete the /var/run/sickbeard directory and start sickbeard again

# sudo rmdir /var/run/sickbeard

# stop sickbeard
sudo service sickbeard stop

# rename file
mv ~/.sickbeard/autoProcessTV.cfg.sample ~/sickbeard/autoProcessTV.cfg

# add path to sickbeard autoProcessTV to sabnzbd
# replace "username" with your username
# /home/username/.sickbeard/autoProcessTV


# copy the postprocessing scripts to the scripts directory 
cd ~/.sickbeard/autoProcessTV 
cp autoProcessTV.cfg autoProcessTV.py sabToSickBeard.py /media/usbdrive/sabnzbd/scripts


# couch potato server install
#============================

# download with git
git clone https://github.com/RuudBurger/CouchPotatoServer.git

# move couchpotatoserver to ~/.couchpotatoserver
mv CouchPotatoServer ~/.couchpotato

# copy the startup script to the right location
sudo cp ~/.couchpotato/init/ubuntu /etc/init.d/couchpotato

# make the startup script executable
sudo chmod +x /etc/init.d/couchpotato

# edit the couchpotato init script
sudo vim /etc/init.d/couchpotato

# replace "username" with your username
RUN_AS=${CP_USER-username}
APP_PATH=/home/username/.couchpotato


# back up your sdcard with dd
#============================

# backup the sdcard wth dd
sudo dd bs=1M if=/dev/sdb of=/home/djwilcox/Desktop/raspberry_pi.img

# backup the sdcard wth dd and gzip compression
sudo dd bs=1M if=/dev/sdb | gzip > /home/djwilcox/Desktop/raspberry_pi.img.gz

# restore img from gzip to sdcard
sudo gzip -dc /home/djwilcox/Desktop/raspberry_pi.img.gz | dd bs=1M of=/dev/sdb


