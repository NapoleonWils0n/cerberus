#!/bin/bash

# arpon install to stop arp poisioning
sudo apt-get install arpon

# edit the arpon config file
sudo nano /etc/default/arpon

# change the arpon config file from this

# For DARPI uncomment the following line
# DAEMON_OPTS="-q -f /var/log/arpon/arpon.log -g -d"

# Modify to RUN="yes" when you are ready
RUN="no"



# change the arpon config file to this
# For DARPI uncomment DAEMON_OPTS
# then change RUN="no" to RUN="yes"


# For DARPI uncomment the following line
DAEMON_OPTS="-q -f /var/log/arpon/arpon.log -g -d"

# Modify to RUN="yes" when you are ready
RUN="yes"


# start arpon
sudo /etc/init.d/arpon start
