#!/bin/bash

# dansguardian install
sudo apt-get install dansguardian

# uncomment line 430
contentscanner = '/etc/dansguardian/contentscanners/clamdscan.conf'

# change weighted phrase mode to 0
weightedphrasemode = 0


# add clamav user to dansguardian group
usermod -a -G dansguardian clamav

# rotate squid logs
sudo squid3 -k rotate
