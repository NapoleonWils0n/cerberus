# freebsd fibs openvpn

add a second routing table with fibs

```
sudo vim /boot/loader.conf
```

* add the following code to /boot/loader.conf

```
net.fibs=2
```

add default route to gateway for second routing table

```
sudo setfib 1 route add default 192.168.1.1
```

* start openvpn in the 2nd routing table

```
sudo setfibs 1 openvpn --config config.ovpn
```


sudo setfib 1 route delete default 
