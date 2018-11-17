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
fetch http://ftp.freebsd.org/pub/FreeBSD/snapshots/amd64/11.2-STABLE/base.txz -o /tmp/base.txz
```

* Extract base sytem to basejail directory

```
# tar -xf /tmp/base.txz -C /usr/local/jails/basejail
```

### copy config files into the jails

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

* add hostname to jails rc.conf

```
echo hostname=\"basejail\" > /usr/local/jails/basejail/etc/rc.conf
```

* Create a zfs snapshot.

```
zfs snapshot zroot/jails/basejail@11.2
```

You can now clone the snapshot for each new jail you create. If you wanted to create a jail called www, create a new zfs dataset called zroot/jails/www which is cloned from the zroot/jails/basejail@11.0-p10 snapshot.

```
zfs clone zroot/jails/basejail@11.0-p10 zroot/jails/www
```

Jails need an IP address in order to communicate with other machines, but DigitalOcean instances are only given one public IPv4 address, so to get around this we can use PF (Packet Filter) to operate as a NAT and place our jails behind the NAT.

First off we need a new loopback network interface to communicate over, so we should add the following string to /etc/rc.conf:

## host rc.conf

First off we need a new loopback network interface to communicate over, so we should add the following string to /etc/rc.conf:

```
jail_enable="YES"
cloned_interfaces="lo1"
ifconfig_lo1_alias0="inet 172.16.1.1 netmask 255.255.255.0"

# If you need more IP addresses for jails in the future, add
# another line here like
# ifconfig_lo1_alias1="inet 172.16.1.2 netmask 255.255.255.0"
```

This creates a new network interface named lo1 which is given an IP address of 172.16.1.1.  
You can give it a different IP address, but make sure that it’s one of the RFC 1918 private IP addresses.

These network settings will have to be loaded after you save your edits to /etc/rc.conf,  
so you can either restart you machine or run the equivalent ifconfig commands to setup the new interface on a running system.

```
sudo ifconfig lo1 create
sudo ifconfig lo1 alias 172.16.1.1 netmask 255.255.255.0
```

### jail.conf

```
# /etc/jail.conf

# Global settings applied to all jails.

exec.start = "/bin/sh /etc/rc";
exec.stop = "/bin/sh /etc/rc.shutdown";
exec.clean;
mount.devfs;

path = "/usr/local/jails/$name";

# Jail definition for www.
www {
   host.hostname = "www.opperwall.net";
   ip4.addr = 172.16.1.1;
}
```

### pf firewall

```
# /etc/pf.conf

ext_if = "vtnet0"
ext_addr = $ext_if:0
int_if = "lo1"
jail_net = $int_if:network

nat on $ext_if from $jail_net to any -> $ext_addr port 1024:65535 static-port 
```

### start the jail

```
jail -c www
```

You can open a shell within the jail using

```
jexec www sh
```
