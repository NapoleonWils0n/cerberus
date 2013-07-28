#!/bin/bash

# openvpn client install
sudo apt-get install openvpn

# download the vpnbook free openvpn config files
# http://www.vpnbook.com/freevpn

# unzip the config files and cd into the bundle directory
# choose one of the config files to use

# openvpn connect with config file
sudo openvpn --config vpnbook-us1-udp25000.ovpn

# enter username: vpnbook
# enter password: rUt58sce

# press control c to quit the openvpn connection
