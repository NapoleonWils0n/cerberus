# freebsd networkmgr

install networkmgr

```
sudo pkg install networkmgr
```

create the /usr/local/etc/doas.conf file

```
sudo vim /usr/local/etc/doas.conf file
```
add the code below to the /usr/local/etc/doas.conf

```
permit nopass keepenv :wheel cmd netcardmgr                                                                                                       
permit nopass keepenv :wheel cmd detect-nics                                                                                                      
permit nopass keepenv :wheel cmd detect-wifi                                                                                                      
permit nopass keepenv :wheel cmd ifconfig                                                                                                         
permit nopass keepenv :wheel cmd service                                                                                                          
permit nopass keepenv :wheel cmd wpa_supplicant 
```
