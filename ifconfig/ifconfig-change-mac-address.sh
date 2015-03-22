#!/bin/bash

# ifconfig change mac address
#============================

# find the names of your network interfaces

ifconfig

# the name of my wireless network interface is ath0
# replace ath0 with the name of your network interface in the commands below

# bring the network interface down

sudo ifconfig ath0 down


# change the mac address of your network interface

sudo ifconfig ath0 hw ether de:ad:be:ef:c0:fe


# bring the network interface back up

sudo ifconfig ath0 up


# check your mac address has changed

ifconfig ath0
