# freebsd networkmgr

install networkmgr

```
sudo pkg install networkmgr
```

create the /etc/doas.conf file

```
sudo vim /etc/doas.conf
```
add the code below to the /etc/doas.conf file

```
permit nopass keepenv :wheel cmd netcardmgr                                                                                                       
permit nopass keepenv :wheel cmd detect-nics                                                                                                      
permit nopass keepenv :wheel cmd detect-wifi                                                                                                      
permit nopass keepenv :wheel cmd ifconfig                                                                                                         
permit nopass keepenv :wheel cmd service                                                                                                          
permit nopass keepenv :wheel cmd wpa_supplicant 
```
