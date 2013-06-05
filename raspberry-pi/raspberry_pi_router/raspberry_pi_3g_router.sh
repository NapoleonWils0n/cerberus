#!/bin/sh


#|------------------------------------------------------------------------------
#| Raspberry Pi 3g wifi router 
#|------------------------------------------------------------------------------

# create a 3g router with a rasoberry pi by tethering an andriod phone,
# and using a alfa usb wireless card and portable battery to create a wifi access point

# uses hostapd to create the wireless access point and dnsmasq a dns and dhcp server


#|------------------------------------------------------------------------------
#|	android usb tethering power issue
#|------------------------------------------------------------------------------

# open setting / developer options

# uncheck:

# Stay awake
# Screen will never sleep while charging

# When you use usb tethering to the raspberry pi it will draw too much power if Stay Awake is checked, 
# and will keep dropping the usb tethering connection


#|------------------------------------------------------------------------------
#| Files to edit or create
#|------------------------------------------------------------------------------

# hostapd
/etc/default/hostapd

# hostapd.conf
/etc/hostapd/hostapd.conf

# dnsmasq.conf
/etc/dnsmasq.conf

# network interfaces
/etc/network/interfaces

# dhclient.conf
/etc/dhcp/dhclient.conf

# sysctl.conf
/etc/sysctl.conf

# iptables.rules
/etc/iptables.rules

# ifplugd
/etc/default/ifplugd

# sshd_config
/etc/ssh/sshd_config

# sshd
/etc/pam.d/sshd

# tightvnc
/etc/init.d/tightvncserver

# proxychains
/etc/proxychains.conf

# avahi ssh service
/etc/avahi/services/ssh.service

# avahi vnc service
/etc/avahi/services/rfb.service

#|------------------------------------------------------------------------------
#|	things to install
#|------------------------------------------------------------------------------

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install tightvncserver

sudo apt-get install proxychains

sudo apt-get install avahi-daemon

sudo apt-get install bridge-utils 

sudo apt-get install iw

sudo apt-get install hostapd

sudo apt-get install dnsmasq

sudo apt-get install firmware-ralink

sudo apt-get install libpam-google-authenticator

#----------------------------------------------------------------------------------------#
# preparing the sdcard
#----------------------------------------------------------------------------------------#

# list the hard drives
df -h

# mac drive
# /dev/disk1     112Gi   92Gi   20Gi    83%    /

# insert the sd card and run df -h again and you should see a new drive

# sd card
# /dev/disk2s1   7.4Gi  1.7Mi  7.4Gi     1%    /Volumes/NO NAME


# Unmount the partition so that you will be allowed to overwrite the disk:
diskutil unmount /dev/disk2s1


# Using the device name of the partition work out the raw device name for the entire disk,
# by omitting the final "s1" and replacing "disk" with "rdisk":

# e.g. /dev/disk2s1 => /dev/rdisk2

# In the terminal write the image to the card with this command, using the raw disk device name from above:

sudo dd bs=1m if=~/Downloads/debian6-19-04-2012/debian6-19-04-2012.img of=/dev/rdisk2


# After the dd command finishes, eject the card:
diskutil eject /dev/rdisk2


#|------------------------------------------------------------------------------
#| Raspi-confi - booting up the pi
#|------------------------------------------------------------------------------


# On first boot you will come to the Raspi-config window
# Change settings such as timezone and locale if you want


# Finally, select the second choice

# expand_rootfs

# click finshed by pressing tab, and say ‘yes’ to a reboot


# find the Raspberry Pi ip address by scanning the network subnet with nmap

nmap -sV 192.168.1.1/24


# Nmap scan report for 192.168.1.6
# Host is up (0.081s latency).
# Not shown: 999 closed ports
# PORT   STATE SERVICE VERSION
# 22/tcp open  ssh     OpenSSH 6.0p1 Debian 3 (protocol 2.0)
# Service Info: OS: Linux; CPE: cpe:/o:linux:kernel


#|------------------------------------------------------------------------------
#|	change the default password after set up
#|------------------------------------------------------------------------------

# change password
passwd

# enter your new password twice

#|------------------------------------------------------------------------------
#| apt-get update
#|------------------------------------------------------------------------------

sudo apt-get update
sudo apt-get upgrade


#|------------------------------------------------------------------------------
#|	tightvnc server install
#|------------------------------------------------------------------------------

sudo apt-get install tightvncserver

#|------------------------------------------------------------------------------
#|	proxychains
#|------------------------------------------------------------------------------

sudo apt-get install proxychains

# edit config file
sudo nano /etc/proxychains.conf

# uncomment 
dynamic_chain
chain_len = 2

# comment out socks4 	127.0.0.1 9050

# Add ssh proxy setting
socks5	127.0.0.1	8001

# it should look like this

# defaults set to "tor"
#socks4 	127.0.0.1 9050
socks5	127.0.0.1	8001

#|------------------------------------------------------------------------------
#|	ssh tunnel socks 5 proxy 
#|------------------------------------------------------------------------------

# ssh g switch for sharing ssh tunnel on the lan
ssh -g -D 8001 -p 443 username@sshserver.com

# -g = share ssh tunnel on lan
# -D 8001 = localport
# -p 443 = remote ssh port

# search for ssh process
ps aux | grep "[s]sh -D"

# now you can use the ssh tunnel with proxychains

proxyresolv www.cmyip.com

#|------------------------------------------------------------------------------
#|	connect to the ssh tunnel socks 5 proxy
#|------------------------------------------------------------------------------

# You can now connect to the ssh tunnel on the lan as a socks 5 proxy

# Change your network setting to connect to the ip address and port of the computer running the ssh tunnel

# socks proxy 
# ip: 10.0.0.1
# port: 8001


#|------------------------------------------------------------------------------
#|	avahi-daemon - zero config
#|------------------------------------------------------------------------------


sudo apt-get install avahi-daemon
sudo update-rc.d avahi-daemon defaults

#|------------------------------------------------------------------------------
#| avahi-daemon for ssh service
#|------------------------------------------------------------------------------

# After reboot, we should now be able to ssh into the new device by typing

ssh pi@rpi.local

# in a window of the OS X Terminal application (hidden in Applications/Utilities). 
# For added nicety and to have the device appear automatically in the connection selection of some ssh clients (e.g. on iPad), 
# we can also add the ssh service to be explicitly announced by avahi-daemon, by adding a new file /etc/avahi/services/ssh.service

<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h SSH</name>
  <service>
    <type>_ssh._tcp</type>
    <port>22</port>
  </service>
</service-group>


#|------------------------------------------------------------------------------
#| avahi-daemon for vnc service
#|------------------------------------------------------------------------------

sudo vim /etc/avahi/services/rfb.service


<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_rfb._tcp</type>
    <port>5901</port>
  </service>
</service-group>


#|------------------------------------------------------------------------------
#| create tightvncserver script
#|------------------------------------------------------------------------------

cd /etc/init.d

# create a file called tightvncserver and paste in the code below
sudo vim tightvncserver

#!/bin/bash
# /etc/init.d/tightvncserver
#

# Carry out specific functions when asked to by the system
case "$1" in
start)
    su pi -c '/usr/bin/vncserver -geometry 1440x900'
    echo "Starting VNC server "
    ;;
stop)
    pkill vncserver
    echo "VNC Server has been stopped (didn't double check though)"
    ;;
*)
    echo "Usage: /etc/init.d/blah {start|stop}"
    exit 1
    ;;
esac

exit 0


#-----------------------------------------------#

# make the script executable
sudo chmod +x tightvncserver
sudo pkill Xtightvnc

# start tightvncserver
sudo /etc/init.d/tightvncserver start

cd /etc/init.d

# update the defaults to use the tightvncserver script
sudo update-rc.d tightvncserver defaults


#|------------------------------------------------------------------------------
#| restart avahi-daemon
#|------------------------------------------------------------------------------

sudo /etc/init.d/avahi-daemon restart


#|------------------------------------------------------------------------------
#| install bridge-utils for brctl
#|------------------------------------------------------------------------------

# install bridge-utils for brctl so you can bridge the usb0 interface to wlan0
sudo apt-get install bridge-utils 


#|------------------------------------------------------------------------------
#| install wireless tools
#|------------------------------------------------------------------------------

# install wireless tools
sudo apt-get install iw


#|------------------------------------------------------------------------------
#|	ssh in and start the vnc server
#|------------------------------------------------------------------------------


# ssh into the pi
ssh pi@192.168.1.6

# start the tightvnc server
vncserver :1

# you can now log in with a vnc client like screens on the mac


#|------------------------------------------------------------------------------
#|	 3g usb set up
#|------------------------------------------------------------------------------


# Edit the /etc/network/interfaces file to look like this:

# Set up the local loopback interface
auto lo usb0 wlan0 eth0
iface lo inet loopback


# Ethernet
iface eth0 inet static 
address 10.0.1.2
netmask 255.255.255.0

# Wlan
iface wlan0 inet static
address 10.0.0.1
netmask 255.255.255.0
pre-up iptables-restore < /etc/iptables.rules

# USB
#allow-hotplug usb0
iface usb0 inet dhcp


#|------------------------------------------------------------------------------
#| stopping and starting the network service
#|------------------------------------------------------------------------------

# To start Linux network service:
sudo /etc/init.d/networking start

# To stop Linux network service:
sudo /etc/init.d/networking stop

#|------------------------------------------------------------------------------
#|	wifi access point
#|------------------------------------------------------------------------------

# install hostapd to create a wifi access point
sudo apt-get install hostapd

# install dnsmasq to create a dns dhcp server
sudo apt-get install dnsmasq


#|------------------------------------------------------------------------------
#| find the usb wifi make
#|------------------------------------------------------------------------------

# find the usb wifi make
lsmod

# find the usb wifi make
lsusb

# install firmware-ralink
sudo apt-get install firmware-ralink

# Ralink 802.11n PCI devices are supported by the rt2800pci driver
modinfo rt2800usb

# the hostapd driver is nl80211
driver=nl80211

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
server=192.168.42.129


# tell dnsmasq to listen on wlan0 eth0 on 127.0.0.1, but not usb0

# If you want dnsmasq to listen for DHCP and DNS requests only on
# specified interfaces (and the loopback) give the name of the
# interface (eg eth0) here.
# Repeat the line for more than one interface.
interface=wlan0
interface=eth0
# Or you can specify which interface _not_ to listen on
except-interface=usb0
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
sudo iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE



# save the ip tables, switch to root first
sudo su

iptables-save > /etc/iptables.rules


# resote iptables, switch to root first
sudo su

iptables-restore < /etc/iptables.rules


#|------------------------------------------------------------------------------
#|	/etc/iptables.rules should look like this
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


#|------------------------------------------------------------------------------
#| google-authenticator for ssh
#|------------------------------------------------------------------------------


# install google-authenticator
sudo apt-get install libpam-google-authenticator


# edit the sshd_config file 
sudo nano /etc/ssh/sshd_config

# change ChallengeResponseAuthentication no to ChallengeResponseAuthentication yes
ChallengeResponseAuthentication yes

# change to the follwoing from yes to no
RSAAuthentication no
PubkeyAuthentication no

# uncomment PasswordAuthentication yes and change to no
PasswordAuthentication no

# edit pam.d/sshd
sudo nano /etc/pam.d/sshd

# add this line
auth required pam_google_authenticator.so


# restart the ssh service
sudo service ssh restart

# log in on the local machine, not via ssh and run google-authenticator
google-authenticator


# 1 - you will see a qr code in the terminal window you can scan with the google auth app

# 2 - copy the secret key to use with oathtool
Your new secret key is: XXXXXXXXXXXXXX

# your verification code
Your Verification code is: 123456

# Your emergency scratch codes
Your emergency scratch codes are:

# copy the secret key to use with oathtool
oathtool -b --totp XXXXXXXXXXXXXX

# then use the secret key with a bash script

#-----------------------------------------------#
# stopping and starting services

# stop and start the networking service
sudo service networking stop
sudo service networking start


# stop and start the ssh service
sudo service ssh stop
sudo service ssh start

# stop and start the hostapd service 
sudo service hostapd start
sudo service hostapd stop


#|------------------------------------------------------------------------------
#|	raspberry pi backup sdcard
#|------------------------------------------------------------------------------

# plug in the sdcard and wait for it mount
# find the disk has been called by running the df -h command
df -h

# the disk should be labeled something like /dev/disk2s1
# you need to unmount the disk before you can copy it

# unmount the disk
diskutil unmountDisk /dev/disk2s1

# backup the sdcard wth dd
sudo dd bs=1m if=/dev/disk2s1 of=/Users/$USER/Desktop/raspberry_pi_router.img