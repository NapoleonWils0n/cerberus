#!/bin/sh

# fwsnort and perl modules install
su -; apt-get install fwsnort

# install perl modules
su -; apt-get install libnetaddr-ip-perl

# download the latest emerging threats list
su -; fwsnort --update-rules

# run fwsnort so it picks up the the emerging threats list
su -; fwsnort

# run the generated script to add the emerging threats list to iptables
su -; /var/lib/fwsnort/fwsnort.sh
