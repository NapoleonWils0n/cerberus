# freebsd geli change password

change geli password for encrypted zfs root partition

find the root partition

```
ls /dev/ | grep eli
```

because i have an encrypted root and swap partition this returns 2 partitions

ada0p4.eli
ada0p5.eli

so we need to check /etc/fstab to see which partition is the swap and which is the root partition

```
less /etc/fstab
```

this shows the swap partition is /dev/ada0p4 in the fstab  
so we know the root partition is /dev/ada0p5


## find the size of the existing /boot/encryption.key

we need to find the file size of the existing /boot/encryption.key file

```
ls -l /boot/encryption.key
```

the size is 4096


### create new key file

create the new key file with dd at the same size as the existing key
which is 4096


```
sudo dd if=/dev/zero of=/boot/crypt.key bs=4096 count=1
```

set the new password on the new keyfile for the root partition  
we need to pass in the existing key file which is /boot/encryption.key  
the new key file which is /boot/crypt.key  
and the root partition which is /dev/ada0p5


```
sudo geli setkey -v -k /boot/encryption.key -K /boot/crypt.key /dev/ada0p5
```

you will be prompted for the new password and then confirm the new password,
you wont be prompted to enter the old password


#### edit /boot/loader.conf

now we need to edit the /boot/loader.conf file and  
change path to the key file

```
sudo vim /boot/loader.conf
```

change the path to the key file from the default  
/boot/encryption.key

```
geli_ada0p5_keyfile0_name="/boot/encryption.key"
```

change the path to the new key file
/boot/crypt.key

```
geli_ada0p5_keyfile0_name="/boot/crypt.key"
```

save the file then reboot and use your new password  
to unlock the encrypted root partition
