#!/bin/bash


# openbsd wifi set up
#===================================================================


# find the name of your wireless network interface with ifconfig

ifconfig


# my wireless network interface is called ath0,
# replace ath0 in the commands below with the name of your wireless network interface


# scan for wifi networks

ifconfig ath0 scan


# Connect to the access point:

ifconfig ath0 nwid "network-name" wpakey "mypassword"


# get a ip address by running dhclient with the name of your wireless network interface

dhclient ath0