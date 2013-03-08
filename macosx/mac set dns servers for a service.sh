#!/bin/bash

# list all network services on a mac
networksetup -listallnetworkservices

# set dns servers for a service
networksetup -setdnsservers Nexus\ 4 8.8.8.8 8.8.4.4


