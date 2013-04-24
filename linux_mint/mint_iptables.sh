#|------------------------------------------------------------------------------
#| iptables
#|------------------------------------------------------------------------------


# iptables for avahi and shairport speakers

sudo iptables -L


# Now you have to define certain rules, so that the IP packages can be handed over. 

# This file contains the following lines

sudo iptables -F
sudo iptables -X
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 5353 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 5000:5005 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 6000:6005 -s 192.168.1.0/24 -j ACCEPT


# save the ip tables, switch to root first
sudo su

iptables-save > /etc/iptables.rules


# resote iptables, switch to root first
sudo su

iptables-restore < /etc/iptables.rules


#|------------------------------------------------------------------------------
#| edit /etc/network/interfaces
#|------------------------------------------------------------------------------

# add pre-up iptables-restore < /etc/iptables.rules 

# Edit the /etc/network/interfaces file to look like this:

# Set up the local loopback interface
auto lo
iface lo inet loopback

# Wlan
auto wlan0
iface wlan0 inet dhcp
pre-up iptables-restore < /etc/iptables.rules

