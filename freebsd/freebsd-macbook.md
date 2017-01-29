# Freebsd macbook install

* Download iso file
* Burn to disc
* Insert disc restart mac and hold down alt to boot into efi mode

## root on zfs

Select root on zfs during install

* encrypt discs
* encrypt swap
* swap size 8gig

## set the root password

* set the root password
* create new user
* add new user to wheel group
## single user mode require root password

change single user mode to requite root password
change setting from secure to insecure to require root password

edit /etc/ttys

```
sudo nano /etc/ttys
```

* change settings to insecure

```
console none unknown off insecure
```

## bootstrap the system

To bootstrap the system, run:

```
# /usr/sbin/pkg
```
