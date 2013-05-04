#|------------------------------------------------------------------------------
#| iptables
#|------------------------------------------------------------------------------


# iptables for avahi and shairport speakers

sudo iptables -L

### flush existing rules and set chain policy setting to DROP
sudo iptables -F
sudo iptables -X

###### INPUT chain

### state tracking rules
sudo iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A INPUT -m state --state INVALID -j DROP
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

### ACCEPT rules
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 5353 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --dport 5000:5005 -s 192.168.1.0/24 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 6000:6005 -s 192.168.1.0/24 -j ACCEPT

###### OUTPUT chain ######

sudo iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
sudo iptables -A OUTPUT -m state --state INVALID -j DROP
sudo iptables -A OUTPUT -o lo -j ACCEPT



##############################################

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
pre-up iptables-restore < /etc/iptables.rules


#|------------------------------------------------------------------------------
#| fwsnort download the latest emerging threats list
#|------------------------------------------------------------------------------

# download the latest emerging threats list
sudo fwsnort --update-rules

# run fwsnort so it picks up the the emerging threats list
sudo fwsnort

# run the generated script to add the emerging threats list to iptables
sudo /var/lib/fwsnort/fwsnort.sh

