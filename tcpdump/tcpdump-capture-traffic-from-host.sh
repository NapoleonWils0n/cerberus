#!/bin/bash

# tcpdump capture traffic from host
#===================================

sudo tcpdump -s 0 host 192.168.1.4 -i wlan0 -w wlan0.pcap