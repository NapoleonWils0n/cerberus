#!/bin/bash

# raspberry pi portable wifi nas
#===============================


# plugin the sdcard to your sdcard reader and plug in to your usb port

# find the sdcards device name with df or fdisk
df -h

sudo fdisk -l 


# umount the sdcard
umount /dev/sdb

# copy the disk image to the sdcard
sudo dd bs=1M if=~/Downloads/debian6-19-04-2012.img of=/dev/sdb



# expand sdd
sudo raspi-config



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
rpi


# edit the /etc/hostname file
sudo nano /etc/hostname

# change the hostname to pi
rpi

sudo /etc/init.d/hostname.sh

sudo reboot

# you should now be able to ssh into the pi with the shortened hostname and with a .local address
#================================================================================================
ssh pi@pi.local


# set your linux laptop to save ssh key passwords in the gnome keyring
#======================================================================

# Set up GnomeKeyring in XFce goto Settings-Session and Startup-Advanced 
# select Launch GNOME services on startup and it saved the identity to the keyring.


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

ssh-copy-id djwilcox@rpi.local

# you should now be able to ssh into the pi using ssh keys
ssh djwilcox@rpi.local

# secure ssh to only allow ssh keys 
#==================================

# no root log in via ssh, no password logins only ssh keys

sudo nano /etc/ssh/sshd_config

PermitRootLogin no
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no


# wireless access point
#======================

sudo apt-get install iw
sudo apt-get install hostapd
sudo apt-get install dnsmasq



# Edit the /etc/network/interfaces file to look like this:

# Set up the local loopback interface
auto lo wlan0 eth0
iface lo inet loopback

# Ethernet
iface eth0 inet dhcp 

# Wlan
iface wlan0 inet static
address 10.0.0.1
netmask 255.255.255.0
pre-up iptables-restore < /etc/iptables.rules

# start and stopping network services
#====================================


# To start Linux network service:
sudo /etc/init.d/networking start

# To stop Linux network service:
sudo /etc/init.d/networking stop

#|------------------------------------------------------------------------------
#| edit the hostapd file
#|------------------------------------------------------------------------------

# edit the hostapd file
sudo nano /etc/default/hostapd

# uncomment DAEMON_CONF and add the path to the config you are about to create
DAEMON_CONF="/etc/hostapd/hostapd.conf"

# Content of /etc/hostapd/hostapd.conf

# 1 - The Device which will act as AP, The interface to listen on
interface=wlan0

# 2 - driver for usb wifi dongle
driver=nl80211

# 3 - Parameters so that the daemon runs
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0

# 4 - The Wifi configuration
ssid=pi
channel=6
hw_mode=g
ieee80211n=1

# 5 - Security of the Wifi connection
wpa=2
#wpa_psk=928519398acf811e96f5dcac68a11d6aa876140599be3dd49612e760a2aaac0e
# The line above sets the wpa passphrase to "raspiwlan", this is obtained via the wpa_passphrase command.
# However, you can also set a passphrase like the line below.
wpa_passphrase=wifipassword
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
rsn_pairwise=CCMP

# 6 - Other settings
beacon_int=100
auth_algs=3
wmm_enabled=1


#|------------------------------------------------------------------------------
#| /etc/hostapd/hostapd.conf file should look like this
#|------------------------------------------------------------------------------

interface=wlan0
driver=nl80211

ctrl_interface=/var/run/hostapd
ctrl_interface_group=0

ssid=pieandchips
channel=6
hw_mode=g
ieee80211n=1


wpa=2
wpa_passphrase=wifipassword
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
rsn_pairwise=CCMP

beacon_int=100
auth_algs=3
wmm_enabled=1


#|------------------------------------------------------------------------------
#| edit the /etc/dnsmasq.conf file
#|------------------------------------------------------------------------------

# edit the config file in /etc/dnsmasq.conf, start up hostapd and restart dnsmasq.

# uncomment the following


# By  default,  dnsmasq  will  send queries to any of the upstream
# servers it knows about and tries to favour servers to are  known
# to  be  up.  Uncommenting this forces dnsmasq to try each query
# with  each  server  strictly  in  the  order  they   appear   in
# /etc/resolv.conf
strict-order

# If you don't want dnsmasq to read /etc/resolv.conf or any other
# file, getting its servers from this file instead (see below), then
# uncomment this.
no-resolv

# If you don't want dnsmasq to poll /etc/resolv.conf or other resolv
# files for changes and re-read them then uncomment this.
no-poll

# add the localhost dnsmasq server, google dns servers, and your isps dns nameserver

# Add other name servers here, with domain specs if they are for
# non-public domains.
#server=/localnet/192.168.0.1

server=127.0.0.1
server=8.8.8.8
server=8.8.4.4


# tell dnsmasq to listen on wlan0 eth0 on 127.0.0.1, but not usb0

# If you want dnsmasq to listen for DHCP and DNS requests only on
# specified interfaces (and the loopback) give the name of the
# interface (eg eth0) here.
# Repeat the line for more than one interface.
interface=wlan0
#interface=eth0
# Or you can specify which interface _not_ to listen on
#except-interface=usb0
# Or which to listen on by address (remember to include 127.0.0.1 if
# you use this.)
listen-address=127.0.0.1


# add the dhcp-range for wlan0 and eth0

# Uncomment this to enable the integrated DHCP server, you need
# to supply the range of addresses available for lease and optionally
# a lease time. If you have more than one network, you will need to
# repeat this for each network on which you want to supply DHCP
# service.
dhcp-range=10.0.0.2,10.0.0.20,255.255.255.0,12h
dhcp-range=10.0.1.2,10.0.1.20,255.255.255.0,12h

# Then we will add this line to dnsmasq.conf.
# The IP address is the same one we gave to the WiFi adapter back in Part 1


# Override the default route supplied by dnsmasq, which assumes the
# router is the same machine as the one running dnsmasq.
dhcp-option=3,10.0.0.1


# block isp dns
#bogus-nxdomain=194.71.107.15
#bogus-nxdomain=195.144.21.19
#bogus-nxdomain=195.144.21.16


#|------------------------------------------------------------------------------
#| edit the dhclient.conf file
#|------------------------------------------------------------------------------

# Now, edit the dhclient.conf file

sudo nano /etc/dhcp/dhclient.conf
# uncomment # prepend domain-name-servers 127.0.0.1;

#supersede domain-name "fugue.com home.vix.com";
prepend domain-name-servers 127.0.0.1;
request subnet-mask, broadcast-address, time-offset, routers,
domain-name, domain-name-servers, host-name,
netbios-name-servers, netbios-scope;


#-----------------------------------------------#

# restart dnsmasq for the changes to take affect
sudo service dnsmasq stop

sudo service dnsmasq start


#|------------------------------------------------------------------------------
#| enable packet forwarding
#|------------------------------------------------------------------------------


# First thing we need to do is to enable packet forwarding.
# In the file /etc/sysctl.conf, we need to uncomment the following line (should be line 28).
net.ipv4.ip_forward=1


# After changing that, run this command to re-read the sysctl.conf file
sysctl -p

#-----------------------------------------------#


# To make this work on boot, can put the relevant config in /etc/default/hostapd
RUN_DAEMON="yes"
DAEMON_CONF="/etc/hostapd/hostapd.conf"
DAEMON_OPTS="-dd"


#-----------------------------------------------#


# start hostapd
/etc/init.d/hostapd start


# stop hostapd
/etc/init.d/hostapd stop


# start dnsmasq
/etc/init.d/dnsmasq start


# stop dnsmasq
/etc/init.d/dnsmasq stop



#|------------------------------------------------------------------------------
#| iptables
#|------------------------------------------------------------------------------


iptables -L


# Now you have to define certain rules, so that the IP packages can be handed over. 

# This file contains the following lines

sudo iptables -F
sudo iptables -X
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE



# save the ip tables, switch to root first
sudo su

iptables-save > /etc/iptables.rules


# resote iptables, switch to root first
sudo su

iptables-restore < /etc/iptables.rules


#|------------------------------------------------------------------------------
#|        /etc/iptables.rules should look like this
#|------------------------------------------------------------------------------

# Generated by iptables-save v1.4.14 on Thu Mar 21 20:21:53 2013
*nat
:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
-A POSTROUTING -o usb0 -j MASQUERADE
-A POSTROUTING -o usb0 -j MASQUERADE
COMMIT
# Completed on Thu Mar 21 20:21:53 2013
# Generated by iptables-save v1.4.14 on Thu Mar 21 20:21:53 2013
*filter
:INPUT ACCEPT [4:304]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [4:304]
-A INPUT -i lo -j ACCEPT
-A OUTPUT -o lo -j ACCEPT
COMMIT
# Completed on Thu Mar 21 20:21:53 2013

#-----------------------------------------------#

# add this under wlan0 in /etc/network/interfaces 
pre-up iptables-restore < /etc/iptables.rules


#|------------------------------------------------------------------------------
#| why wlan0 doesn’t get an IP address when hostapd starts up
#|------------------------------------------------------------------------------


# So, I figured out why wlan0 doesn’t get an IP address when hostapd starts up.
# ifplugd messes about with the interfaces when they go up and down, so the simplest solution is to disable ifplugd for wlan0 !
# in /etc/default/ifplugd, the default configuration is this

INTERFACES="auto"
HOTPLUG_INTERFACES="all"
ARGS="-q -f -u0 -d10 -w -I"
SUSPEND_ACTION="stop"

# Simply changing it to this

INTERFACES="eth0"
HOTPLUG_INTERFACES="eth0"
ARGS="-q -f -u0 -d10 -w -I"
SUSPEND_ACTION="stop"

# will ensure that wlan0 will not lose it’s static IP address that’s configured in /etc/network/interfaces when wlan0 goes up.


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
/dev/sda1 /media/usbdrive auto noatime nodiratime 0 0


# change permissions on the drive so both pi and new user djwilcox have write access
#===================================================================================

sudo chown -R djwilcox:djwilcox /media/usbdrive
sudo chmod -R 777 /media/usbdrive



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


# make samba listen on both wlan0 and eth0
#=========================================


#### Networking ####

# The specific set of interfaces / networks to bind to
# This can be either the interface name or an IP address/netmask;
# interface names are normally preferred
;   interfaces = 127.0.0.0/8 eth0
interfaces = eth0 wlan0



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

# back up your sdcard with dd
#============================

# backup the sdcard wth dd
sudo dd bs=1M if=/dev/sdb of=/home/djwilcox/Desktop/raspberry_pi.img

# backup the sdcard wth dd and gzip compression
sudo dd bs=1M if=/dev/sdb | gzip > /home/djwilcox/Desktop/raspberry_pi.img.gz

# restore img from gzip to sdcard
sudo gzip -dc /home/djwilcox/Desktop/raspberry_pi.img.gz | dd bs=1M of=/dev/sdb


