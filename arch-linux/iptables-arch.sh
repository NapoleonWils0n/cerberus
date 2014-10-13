#!/bin/bash


# iptables (firewall)
#========================================================================================

# iptables for rtorrent

sudo iptables -L

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

# rtorrent
sudo iptables -A INPUT -p tcp --dport 6881 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 6882 -s 192.168.1.0/24 -j ACCEPT

# shairport iptables
sudo iptables -A INPUT -p tcp -m tcp --dport 5353 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 5000:5005 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 6000:6005 -s 192.168.1.0/24 -j ACCEPT

# ntp time
sudo iptables -I INPUT -p udp --dport 123 -j ACCEPT


# OUTPUT chain
#=============

sudo iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A OUTPUT -m state --state INVALID -j DROP
sudo iptables -I OUTPUT -p udp --sport 123 -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT


# save iptables rules
#====================


# save the ip tables, switch to root first
sudo su

iptables-save > /etc/iptables/iptables.rules


# resote iptables, switch to root first
sudo su

iptables-restore < /etc/iptables/iptables.rules




# edit iptables.service
#=============================
sudo nano /usr/lib/systemd/system/iptables.service


    [Unit]
    Description=Packet Filtering Framework

    [Service]
    Type=oneshot
    RemainAfterExit=yes
    ExecStart=/usr/sbin/iptables-restore /etc/iptables/iptables.rules
    ExecStop=/usr/lib/systemd/scripts/iptables-flush

    [Install]
    WantedBy=multi-user.target


# enable iptables service
#=============================


# systemctl enable iptables
# systemctl start iptables

# systemctl reload iptables

