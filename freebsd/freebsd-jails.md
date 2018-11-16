# freebsd jails

freebsd jails for services

* switch to root

```
sudo su
```

create zfs dataset for jails

```
zfs create -o mountpoint=/usr/local/jails zroot/jails
```

We can then create a new dataset named basejail in zroot/jails

```
zfs create zroot/jails/basejail
```

## download the base system tarball

* download 11.2 base system tarball

```
fetch http://ftp.freebsd.org/pub/FreeBSD/snapshots/amd64/11.2-STABLE/base.txz
```

* Extract base sytem to basejail directory

```
# tar -xf /mnt/usr/freebsd-dist/base.txz -C /usr/local/jails/basejail
```

* Copy resolv.conf into the jail

```
cp /etc/resolv.conf /usr/local/jails/basejail/etc
```

* copy localtime to jail

```
cp /etc/localtime /usr/local/jails/basejail/etc/localtime
```

* Run freebsd update on the basejail system.

```
freebsd-update -b /usr/local/jails/basejail fetch install
```

* verify the freebsd checksum

```
freebsd-update -b /usr/local/jails/basejail IDS
```

* Create a zfs snapshot.

```
zfs snapshot zroot/jails/basejail@11.2
```

You can now clone the snapshot for each new jail you create. If you wanted to create a jail called www, create a new zfs dataset called zroot/jails/www which is cloned from the zroot/jails/basejail@11.0-p10 snapshot.

Jails need an IP address in order to communicate with other machines, but DigitalOcean instances are only given one public IPv4 address, so to get around this we can use PF (Packet Filter) to operate as a NAT and place our jails behind the NAT.

First off we need a new loopback network interface to communicate over, so we should add the following string to /etc/rc.conf:

## rc.conf

```
jail_enable="YES"
cloned_interfaces="lo1"
ifconfig_lo1_alias0="inet 172.16.1.1 netmask 255.255.255.0"

# If you need more IP addresses for jails in the future, add
# another line here like
# ifconfig_lo1_alias1="inet 172.16.1.2 netmask 255.255.255.0"
```


### pf firewall
