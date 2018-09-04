# zfs snapshot usb drive

list the disks

```
geom disk list
```

switch to root

```
sudo su
```

destroy drive

```
gpart destroy -F da0
dd if=/dev/zero of=/dev/da0 bs=1m count=128
```

create mount point

```
mkdir -p /mnt/usb
```

crete zfs pool on the external drive

```
zpool create zbackup /dev/da0
zfs set mountpoint=/mnt/usb zbackup
```

list zfs directory structure

```
zfs list
```

create snapshots

```
zfs snapshot -r bootpool@2017-04-21
zfs snapshot -r zroot@2017-04-21
```

send the snapshots to the corresponding pool on the drive  
use the -R option to create the datasets on the external drive

```
zfs send -Rv bootpool@2017-04-21 | zfs recv -F zbackup/bootpool
zfs send -Rv zroot@2017-04-21 | zfs receive -F zbackup/zroot
```

incremental - take new snapshots

```
zfs snapshot -r bootpool@2017-04-18
zfs snapshot -r zroot@2017-04-18
```

send incremental snapshots  
use the -R option on the zroot pool to send incremental snapshots of the descendant file system


```
zfs send -v -I bootpool@2017-04-18 bootpool@2017-04-21 | zfs recv -F zbackup/bootpool
zfs send -Rv -I zroot@2017-04-18 zroot@2017-04-21 | zfs recv -F zbackup/zroot
```

### zfs unmount drive

```
sudo zfs unmount zbackup
```
