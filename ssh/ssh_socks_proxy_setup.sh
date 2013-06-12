#!/bin/bash

# socks over ssh tunnel slciehost vps

#----------------------------------------------------------------------------------------#
#	ssh server set up  #
#----------------------------------------------------------------------------------------#

# edit the sshd_config with nano as root
# sudo su

# nano /etc/ssh/sshd_config
# PermitTunnel yes
# GatewayPorts yes
# AllowTcpForwarding yes

# or echo to the file
# echo “PermitTunnel yes” >> /etc/ssh/sshd_config
# echo GatewayPorts yes” >> /etc/ssh/sshd_config

# Then, restart your sshd server :
# root@remote-server:~# service ssh restart

# on mac osx you need to go to system prefs and toggle remote login on and off

#----------------------------------------------------------------------------------------#
#	iPad / iPhone proxy set up  #
#----------------------------------------------------------------------------------------#

# On your iPhone/iPod Touch, go to Settings > Wifi 
# and click the blue arrow to the right of your work network, scroll to the bottom, 
# click Auto and type in the address to your PAC file (e.g. http://air.local/~djwilcox/proxy/proxy.pac).

#----------------------------------------------------------------------------------------#
#	pac file  #
#----------------------------------------------------------------------------------------#

# create a file with .pac extension, like proxy.pac
# this file has a javascript functions that find proxy servers 
# it takes two argumnets an ip address and a port number 


#	function FindProxyForURL(url, host) {
#	return "SOCKS 192.168.1.4:1080";
#  }  



#----------------------------------------------------------------------------------------#
#	ssh script  #
#----------------------------------------------------------------------------------------#

## (C) George Goulas, 2011
##
## Proxy service configuration script for OSX
## tested on MacOSX Lion 10.6
##

## SETTINGS
##
# SOCKS PROXY PORT
PORT=8080
# SSH OPTIONS TO CREATE PROXY -g allow lan access
SSH_OPTS="-C2qTnNfgD"
# user@host
SSH_HOST="10.20.30.100"
# SSH PORT
SSH_PORT=30000
# OSX network service to configure proxy for
NET_SERVICE="wi-fi"
# Verbose, if not empty, it prints diagnosing messages
VERBOSE=1
##
## END OF SETTINGS, DO NOT MODIFY PAST THIS POINT
##

SSH_CMD="ssh ${SSH_OPTS} ${PORT} -p ${SSH_PORT} ${SSH_HOST}"

function report {
	MSG=$1
	if [ -n "${VERBOSE}" ]; then 
		echo $MSG
	fi
}

function enableProxy {
	networksetup  -setsocksfirewallproxy ${NET_SERVICE} localhost ${PORT}
	networksetup  -setsocksfirewallproxystate ${NET_SERVICE} on
	${SSH_CMD}
}

function disableProxy {
	ps -ax | grep "${SSH_CMD}" | grep -v grep | awk '{print $1}'| xargs kill
	networksetup  -setsocksfirewallproxystate ${NET_SERVICE} off
}

function showStatus {
	ps -ax | grep "${SSH_CMD}" | grep -v grep > /dev/null
	if [ $? -eq 0 ]; then
		echo SSH SOCKS Proxy status: ON
	else
		echo SSH SOCKS Proxy status: OFF
	fi
	networksetup -getsocksfirewallproxy ${NET_SERVICE} | grep Enabled | grep Yes > /dev/null
	if [ $? -eq 0 ]; then
		echo Proxy setting in network setup for ${NETSERVICE}: ON
	else
		echo Proxy setting in network setup for ${NETSERVICE}: OFF
	fi
}

case "$1" in

	on)	report "Enabling Proxy"
		enableProxy
		;;

	off)	report "Disabling Proxy"
		disableProxy
		;;
	
	status) echo status
		showStatus
		;;
	*) echo Options: on to enable proxy, off to disable, status to see status.
esac