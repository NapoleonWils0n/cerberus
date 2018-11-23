# freebsd jails

work in progress

freebsd thin jails for services

* switch to root

```
sudo su
```

create a zfs dataset for jails and set the mountpoint

```
zfs create -o mountpoint=/usr/local/jails zroot/jails
```

create a dataset for the thinjails and the name of the release you are going to download


```
zfs create -p zroot/jails/thinjails
zfs create -p zroot/jails/releases/11.2-RELEASE
```

## download the base system tarball

download base system tarball,  
change the url from 11.2-STABLE to the release version you want

```
fetch http://ftp.freebsd.org/pub/FreeBSD/snapshots/amd64/11.2-STABLE/base.txz -o /tmp/base.txz
```

we use the built in fetch command to download the file rather than wget or curl which arent installed by default


* Extract the base sytem to the 11.2-RELEASE directory

```
# tar -xf /tmp/base.txz -C /usr/local/jails/releases/11.2-RELEASE
```

Make sure you jail has the right timezone and dns servers and a hostname in rc.conf.

```
cp /etc/resolv.conf /usr/local/jails/releases/11.2-RELEASE/etc
cp /etc/localtime /usr/local/jails/releases/11.2-RELEASE/etc/localtime
echo hostname=\"basejail\" > /usr/local/jails/releases/11.2-RELEASE/etc/rc.conf
```

### update freebsd base install

Run freebsd update on the basejail system.

```
freebsd-update -b /usr/local/jails/releases/11.2-RELEASE fetch install
```

* verify the freebsd checksum

```
freebsd-update -b /usr/local/jails/releases/11.2-RELEASE IDS
```

## jail template


* Create a zfs snapshot.

```
zfs snapshot zroot/jails/releases/11.2-RELEASE@template
```

use zfs send to send the 11.2-RELEASE snapshot to a new base jail.  
This will be the first layer in future jails.

```
zfs create -p zroot/jails/releases/11.2-RELEASE
zfs send -R zroot/jails/releases/11.2-RELEASE@template | zfs recv zroot/jails/templates/base-11.2-RELEASE
```

Now, some tutorials suggest ZFS cloning (ie. zfs clone). This in itself indeed is the most simple way to clone a basejail to a production jail, however ZFS clones have certain drawbacks which over time completely negate any benefits. A ZFS clone is basically a snapshot, the filesystem is not physically duplicated and it saves all that space (a base 10.3 jail is some 300MB large). At first. Because as you use the jail and update it, more and more of those files are copied to individual jails as they change. Also, you cannot destroy a snapshot which has existing clones. That means you'd have to keep around all the basejail snapshots, or "promote" cloned jails. So why not just send | receive and copy the basejail which is independent from the start. 

### jail skeleton

* Create a skeleton dataset that will be used for jail-specific files

```
zfs create -p zroot/jails/templates/skeleton-11.2-RELEASE
```

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

# The name of each jail. $name is a placeholder.
host.hostname = "${name}.domain.local";

# path to the jail
path = "/usr/local/jails/${name}";

# The IP address of the jail.
ip4.addr = 172.16.1.${ip};

# Jail definition for www.
www {
   $ip = 1;
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
