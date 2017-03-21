# debian dhcp set up

remove network manager resolv.conf

```
rm /var/run/NetworkManager/resolv.conf  
```

edit resolv.conf

```
sudo vim /etc/resolv.conf
```

make sure nameserver is set to 127.0.0.1
if not change and add nameserver 127.0.0.1

```
nameserver 127.0.0.1
```

remove write access with chattr

```
sudo chattr -V +i /etc/resolv.conf
```

edit dhclient.conf

```
sudo vim /etc/dhcp/dhclient.conf
```

add nohook resolv.conf to dhclient.conf

```
nohook resolv.conf
```
