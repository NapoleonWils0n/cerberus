#!/bin/bash

# tcpdump capture get requests on port 80
#========================================

sudo tcpdump -i wlan0 -A 'tcp port 80 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' -w wlan0.pcap




