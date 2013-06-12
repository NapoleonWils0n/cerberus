#!/bin/bash

#-----------------------------------------------#
# Sendmail fix on Mountain Lion
#-----------------------------------------------#

sudo mkdir -p /Library/Server/Mail/Data/spool
sudo /usr/sbin/postfix set-permissions
sudo /usr/sbin/postfix start