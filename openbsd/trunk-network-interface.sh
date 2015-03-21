#!/bin/bash


# openbsd tunk network interface
#===============================


# find the name of your network interfaces with ifconfig
#========================================================

ifconfig



# edit ethernet network interface
#========================================================

sudo vim /etc/hostame.msk0

up



# edit wireless network interface
#========================================================


sudo vim /etc/hostname.ath0

nwid network name goes here
wpakey "wpa key goes here in double quotes"
up

sudo vim /etc/hostname.trunk0

trunkproto failover trunkport msk0
trunkport ath0
dhcp
