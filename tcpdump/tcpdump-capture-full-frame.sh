#!/bin/bash

# tcpdump capture full frame
#===========================

sudo tcpdump -s 0 -i wlan0 -w wlan0.pcap

# capture full frame from ip address on lan
sudo tcpdump -s 0 host 192.168.1.4 -i wlan0 -w wlan0.pcap

