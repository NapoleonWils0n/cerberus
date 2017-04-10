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

Now we want to create a key for GELI to encrypt with, and attach it to our disk image device:

```
dd if=/dev/zero of=/root/storage.key bs=256 count=1
geli init -e aes -l 256 -s 4096 -K /root/storage.key /dev/md0
geli attach -k /root/storage.key /dev/md0
```

Enter passphrase:

## Create the ZFS File System

Next, format the device with the ZFS file system and mount it on an existing mount point:

* use dd to write random data to geli container before adding file system

```
dd if=/dev/random of=/dev/md0.eli bs=1m
```

* To create a simple, non-redundant pool using a single disk device:

```
zpool create crypt /dev/md0.eli
```

* add compression and duplication to the zfs pool

```
zpool set compression=lz4 crypt
```

* zfs set mount point

```
zfs set mountpoint=/home/djwilcox/mnt crypt
```

* mount the encrypted drive to home mnt

```
zfs mount crypt
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

Now, if you want to load the system up later, do the following

```
mdconfig -a -t vnode -f disk.img -u 0
geli attach -k storage.key /dev/md0
mount /dev/md0.eli /mnt

...

umount /mnt
geli detach md0.eli
mdconfig -d -u 0
```
	
