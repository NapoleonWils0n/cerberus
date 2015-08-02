#!/bin/bash

# syncthing install
#======================

# syncthing install
sudo pacman -S syncthing

# syncthing inotify
yaourt -S syncthing-inotify

# firewall settings
#===================

# Port 22000/TCP (or the actual listening port if you have changed the Sync Protocol Listen Address setting.)
# Port 21025/UDP (for discovery broadcasts)


# iptables for syncthing
#=======================



# flush existing rules and set chain policy setting to DROP
#==========================================================
sudo iptables -F
sudo iptables -X


# INPUT chain
#============

# state tracking rules
#=====================

sudo iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A INPUT -m state --state INVALID -j DROP
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


#ACCEPT rules
#============

sudo iptables -A INPUT -i lo -j ACCEPT

# syncthing
sudo iptables -A INPUT -p tcp -m tcp --dport 22000 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 21025 -j ACCEPT


# OUTPUT chain
#=============

sudo iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A OUTPUT -m state --state INVALID -j DROP
sudo iptables -A OUTPUT -o lo -j ACCEPT


# save iptables rules
#====================


# save the ip tables, switch to root first
sudo su

iptables-save > /etc/iptables/iptables.rules


# resote iptables, switch to root first
sudo su

iptables-restore < /etc/iptables/iptables.rules


# enable and start syncthing-inotify
#====================================

systemctl --user enable syncthing-inotify.service
systemctl --user start syncthing-inotify.service

# stopping syncthing
systemctl --user stop syncthing-inotify.service

# show syncthing status
systemctl --user status syncthing-inotify.service


# edit the syncthing-inotify.service
#====================================

# log into the web ui 
# click the actions link in the top right of the window
# and select settings and then copy the api key


# stop syncthing 
systemctl --user stop syncthing-inotify.service


# edit the syncthing-inotify.service

sudo vim /usr/lib/systemd/user/syncthing-inotify.service


# change the ExecStart start from this:

ExecStart=/usr/bin/syncthing-inotify -logflags=0


# Append -api="api-key-from-webui-settings"
# it should look something like this

ExecStart=/usr/bin/syncthing-inotify -logflags=0 -api="uxcYP98gjhgjhTRVVH7666-yutuy6sdk"

# save the file and exit


# reload the systemctl --user daemon
#===================================

systemctl --user daemon-reload

# start syncthing-inotify
systemctl --user start syncthing-inotify.service
