# import zfs pool on external drive and mount

import zfs pool on external drive and mount the drive

first we check if the zfs pool is listed when we run zpool status  
becuase we need to export the pool before we can import it

```
zpool status
```

if the pool is listed when we run zpool status we need to export it  
before we can import it

export the pool

```
sudo zpool export zbackup
```

## import the pool and mount it

mount the pool and set the mount point

```
sudo zpool import -o altroot=/mnt -f zbackup
```

if the zpool was created with a mount point like this

```
zfs set mountpoint=/mnt/usb zbackup
```

then we can mount the pool with this command  
and it will be mounted at the mountpoint set with the zfs set command

```
sudo zpool import -f zbackup
```

