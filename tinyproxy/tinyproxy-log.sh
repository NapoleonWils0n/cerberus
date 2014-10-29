#!/bin/bash

# edit tinyproxy.conf

sudo vim /etc/tinyproxy/tinyproxy.conf


# uncomment 

#LogFile "/var/log/tinyproxy/tinyproxy.log"


#comment out

Syslog On


# uncomment
#DisableViaHeader Yes

#Filter "/etc/tinyproxy/filter"
#FilterURLs On
#FilterExtended On


# create log directory and file

sudo mkdir -p /var/log/tinyproxy
sudo touch /var/log/tinyproxy/tinyproxy.log
sudo chown tinyproxy:tinyproxy /var/log/tinyproxy/tinyproxy.log


# create tinyproxy filter directory and file
sudo touch /etc/tinyproxy/filter
sudo chown tinyproxy:tinyproxy /etc/tinyproxy/filter

sudo vim /etc/tinyproxy/filter
