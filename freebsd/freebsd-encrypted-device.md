# freebsd geli encrypted container

freebsd geli encrypted container

## Load geli Support

Support for geli is available as a loadable kernel module. To configure the system to automatically load the module at boot time, add the following line to /boot/loader.conf:

```
geom_eli_load="YES"
```

## create virtual container with dd

create a 2 gig container with dd on the Desktop called disk.img

* change directory to the Desktop

```
cd ~/Desktop
```

* switch to root

```
sudo su
```

* use dd to create a 2 gig disk image

```
dd if=/dev/zero of=disk.img bs=1M count=2048
```

## mount the image with mdconfig

use mdconfig to mount the disk image

```
mdconfig -a -t vnode -f disk.img -u 0
```

Here, the -a option forces the disk mounting, -t vnode is used for opening a regular file, and the path of this file is specified after -f. The -u 0 option set the virtual disk identifier to use, in this case /dev/md0.

## Generate the Master Key

create directory to store geli key

```
mkdir ~/.ossuary
```

Now we want to create a key for GELI to encrypt with, and attach it to our disk image device:

```
dd if=/dev/zero of=/usr/home/djwilcox/.ossuary/ossuary.key bs=256 count=1
geli init -e aes -l 256 -s 4096 -K /usr/home/djwilcox/.ossuary/ossuary.key /dev/md0
geli attach -k /usr/home/djwilcox/.ossuary/ossuary.key /dev/md0
```

Enter passphrase:

## Create the ZFS File System

Next, format the device with the ZFS file system and mount it on an existing mount point:

* use dd to write random data to geli container before adding file system

```
dd if=/dev/random of=/dev/md0.eli bs=1M
```

* To create a simple, non-redundant pool using a single disk device:

```
zpool create crypt /dev/md0.eli
```

* add compression and duplication to the zfs pool

```
zfs set compression=lz4 crypt
```

* zfs set mount point

```
zfs set mountpoint=/usr/home/djwilcox/mnt crypt
```

* change the permission on the container

```
sudo chmod -R djwilcox:djwilcox ~/mnt
```

Finally, when you want to unmount, we also want to detach from GELI and detach from md:


* zfs unmount

```
zfs umount crypt
```

* geli detach

```
geli detach md0.eli
```

* mdconfig free loop device

```
mdconfig -d -u 0
```

## mounting and unmounting

* mount

use mdconfig to mount the encrypted container to /dev/md0

```
mdconfig -a -t vnode -f disk.img -u 0
```

* use geli with the path to the key and device

```
geli attach -k /usr/home/djwilcox/.ossuary/ossuary.key /dev/md0
```

* we need to import the zpool which will also mount the container

```
zpool import crypt
```


* umount

unmount the zfs pool

```
zfs umount crypt
```

* we need to export the zfs pool before we use geli detach, otherwise geli thinks the device is busy

```
zpool export crypt
```

* use geli to detach the encrypted device

```
geli detach md0.eli
```

* free the loop device

```
mdconfig -d -u 0
```
	
