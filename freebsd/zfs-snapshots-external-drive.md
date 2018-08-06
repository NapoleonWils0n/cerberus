# zfs snapshot uesb drive

list the disks

```
geom disk list
```

destroy drive

```
gpart destroy -F da0
dd if=/dev/zero of=/dev/da0 bs=1m count=128
```

create mount point

```
sudo mkdir -p /mnt/usb
```

crete zfs pool on the external drive

```
zpool create zbackup /dev/da0
zfs set mountpoint=/mnt/usb zbackup
```

zfs set readonly=on zbackup

list zfs directory structure

```
zfs list
```

create the same directory structure on the zfs pool on the external drive

```
zfs create zbackup/bootpool
zfs create zbackup/zroot
zfs create zbackup/zroot/ROOT
zfs create zbackup/zroot/ROOT/default
zfs create zbackup/zroot/tmp
zfs create zbackup/zroot/usr
zfs create zbackup/zroot/usr/home
zfs create zbackup/zroot/usr/ports
zfs create zbackup/zroot/usr/src
zfs create zbackup/zroot/var
zfs create zbackup/zroot/var/audit
zfs create zbackup/zroot/var/crash
zfs create zbackup/zroot/var/log
zfs create zbackup/zroot/var/mail
zfs create zbackup/zroot/var/tmp
```

create snapshots

```
zfs snapshot -r bootpool@2017-04-21
zfs snapshot -r zroot@2017-04-21
```

send the snapshots to the corresponding pool on the drive

```
zfs send -v bootpool@2017-04-21 | zfs receive -F zbackup/bootpool
zfs send -v zroot@2017-04-21 | zfs receive -F zbackup/zroot
zfs send -v zroot/ROOT@2017-04-21 | zfs receive -F zbackup/zroot/ROOT
zfs send -v zroot/ROOT/default@2017-04-21 | zfs receive -F zbackup/zroot/ROOT/default
zfs send -v zroot/tmp@2017-04-21 | zfs receive -F zbackup/zroot/tmp
zfs send -v zroot/usr@2017-04-21 | zfs receive -F zbackup/zroot/usr
zfs send -v zroot/usr/home@2017-04-21 | zfs receive -F zbackup/zroot/usr/home
zfs send -v zroot/usr/ports@2017-04-21 | zfs receive -F zbackup/zroot/usr/ports
zfs send -v zroot/usr/src@2017-04-21 | zfs receive -F zbackup/zroot/usr/src
zfs send -v zroot/var@2017-04-21 | zfs receive -F zbackup/zroot/var
zfs send -v zroot/var/audit@2017-04-21 | zfs receive -F zbackup/zroot/var/audit
zfs send -v zroot/var/crash@2017-04-21 | zfs receive -F zbackup/zroot/var/crash
zfs send -v zroot/var/log@2017-04-21 | zfs receive -F zbackup/zroot/var/log
zfs send -v zroot/var/mail@2017-04-21 | zfs receive -F zbackup/zroot/var/mail
zfs send -v zroot/var/tmp@2017-04-21 | zfs receive -F zbackup/zroot/var/tmp
```

incremental 

```
zfs snapshot -r bootpool@2017-04-18
zfs snapshot -r zroot@2017-04-18
```

send incremental snapshots

```
zfs send -v -I bootpool@2017-04-18 bootpool@2017-04-21 | zfs receive -F zbackup/bootpool
zfs send -v -I zroot@2017-04-18 zroot@2017-04-21 | zfs receive -F zbackup/zroot
zfs send -v -I zroot/ROOT@2017-04-18 zroot/ROOT@2017-04-21 | zfs receive -F zbackup/zroot/ROOT
zfs send -v -I zroot/ROOT/default@2017-04-18 zroot/ROOT/default@2017-04-21 | zfs receive -F zbackup/zroot/ROOT/default
zfs send -v -I zroot/tmp@2017-04-18 zroot/tmp@2017-04-21 | zfs receive -F zbackup/zroot/tmp
zfs send -v -I zroot/usr@2017-04-18 zroot/usr@2017-04-21 | zfs receive -F zbackup/zroot/usr
zfs send -v -I zroot/usr/home@2017-04-18 zroot/usr/home@2017-04-21 | zfs receive -F zbackup/zroot/usr/home
zfs send -v -I zroot/usr/ports@2017-04-18 zroot/usr/ports@2017-04-21 | zfs receive -F zbackup/zroot/usr/ports
zfs send -v -I zroot/usr/src@2017-04-18 zroot/usr/src@2017-04-21 | zfs receive -F zbackup/zroot/usr/src
zfs send -v -I zroot/var@2017-04-18 zroot/var@2017-04-21 | zfs receive -F zbackup/zroot/var
zfs send -v -I zroot/var/audit@2017-04-18 zroot/var/audit@2017-04-21 | zfs receive -F zbackup/zroot/var/audit
zfs send -v -I zroot/var/crash@2017-04-18 zroot/var/crash@2017-04-21 | zfs receive -F zbackup/zroot/var/crash
zfs send -v -I zroot/var/log@2017-04-18 zroot/var/log@2017-04-21 | zfs receive -F zbackup/zroot/var/log
zfs send -v -I zroot/var/mail@2017-04-18 zroot/var/mail@2017-04-21 | zfs receive -F zbackup/zroot/var/mail
zfs send -v -I zroot/var/tmp@2017-04-18 zroot/var/tmp@2017-04-21 | zfs receive -F zbackup/zroot/var/tmp
```

### zfs unmount drive

```
sudo zfs unmount zbackup
```
