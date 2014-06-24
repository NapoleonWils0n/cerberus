#!/bin/bash

# ifconfig set ip adddress
#=========================

# switch to root
sudo su

# use ifconfig to change ip address
ifconfig wlan0 192.168.1.5 netmask 255.255.255.0 up

# use dhclient 
dhclient

