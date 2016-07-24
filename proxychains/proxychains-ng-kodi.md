# proxychains-ng

* [proxychains-ng site](https://github.com/rofl0r/proxychains-ng)

## arch linux proxychains-ng

```
sudo pacman -S proxychains-ng
```

## ubuntu proxychains-ng 

```
sudo apt install proxychains
```

### edit the proxychains-ng config

* edit the proxychains-ng config file and your sock5s details

```
sudo vim /etc/proxychains.conf
```

* you can comment out the socks4 used for tor at the bottom of the file 

```
#socks4         127.0.0.1 9050
```

* add your socks5 details and save

```
socks5          127.0.0.1 1080
```

## using proxychains-ng with Kodi

We can use proxychains-ng with Kodi to unblock addons

```
proxychains-ng kodi
```
