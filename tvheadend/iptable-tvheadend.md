# iptables tvheadend

iptables for tvheadend

switch to root

```
sudo su
```

run the commands below to set up iptables  
except the lines that start with the hash symbol which are comments

```
iptables -L
# flush existing rules and set chain policy setting to DROP
iptables -F
iptables -X
# INPUT chain
iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
# tvheadend ports
iptables -A INPUT -p tcp --dport 9881 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 9882 -s 192.168.1.0/24 -j ACCEPT
# ntp time port
iptables -I INPUT -p udp --dport 123 -j ACCEPT
iptables -I OUTPUT -p udp --sport 123 -j ACCEPT
# OUTPUT chain
iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
iptables -A OUTPUT -m state --state INVALID -j DROP
iptables -A OUTPUT -o lo -j ACCEPT
```


## save iptables rules

make sure you are root

switch to root

```
sudo su
```

install iptables-persistent to save iptables rules so they start at boot

```
apt install iptables-persistent
```

save the iptables rules so they are applied at boot time

```
iptables-save > /etc/iptables/iptables.rules
```


if you need to restore the iptables rule  
switch to root first

```
sudo su
```

then restore the iptables rules

```
iptables-restore < /etc/iptables/iptables.rules
```

### enable iptables

switch to root first

```
sudo su
```

enable iptables to start at boot time

```
systemctl enable iptables
```

start iptables

```
systemctl start iptables
```

reload iptables

```
systemctl reload iptables
```

