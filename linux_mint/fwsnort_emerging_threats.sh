#!/bin/sh

# fwsnort and perl modules install
sudo apt-get install fwsnort

# install perl modules
sudo apt-get install libnetaddr-ip-perl

# download the latest emerging threats list
sudo fwsnort --update-rules

# run fwsnort so it picks up the the emerging threats list
sudo fwsnort

# run the generated script to add the emerging threats list to iptables
sudo /var/lib/fwsnort/fwsnort.sh
