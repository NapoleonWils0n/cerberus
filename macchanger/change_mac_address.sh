#!/bin/sh

#----------------------------------------------------------------------------------------#
#	change mac address  #
#----------------------------------------------------------------------------------------#

# use ifconfig and grep to search for HWaddr ( hardware address )
ifconfig | grep HWaddr

# put the wifi card down
ifconfig wlan0 down

# change the wifi card mac address
ifconfig wlan0 hw ether de:ad:be:ef:c0:fe

# put the wifi card up
ifconfig wlan0 up


# change mac address

# change ethernet mac address with ifconfig
ifconfig eth0 hw ether 11:11:11:11:11:ab

# macchanger randomm address
macchanger -r

# by vendor
macchanger -a
macchanger -A