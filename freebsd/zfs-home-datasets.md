# zfs datasets

zfs list datasets

```
zfs list
```

the name of the main pool is called zpool

* switch to root

```
sudo su
```

## create the zfs datasets

create the main dataset under zpool

```
zfs create zroot/data
zfs create zroot/data/desktop
zfs create zroot/data/documents
zfs create zroot/data/downloads
zfs create zroot/data/git
zfs create zroot/data/kodi
zfs create zroot/data/config
zfs create zroot/data/emacsd
zfs create zroot/data/local
zfs create zroot/data/mozilla
zfs create zroot/data/ossuary
zfs create zroot/data/weechat
```

### copy directories to zfs datasets

copy files to the dataset before setting the mount point and mounting the dataset

```
sudo cp -Rpv /home/djwilcox/Desktop/ /zroot/data/desktop
sudo cp -Rpv /home/djwilcox/documents/ /zroot/data/documents
sudo cp -Rpv /home/djwilcox/downloads/ /zroot/data/downloads
sudo cp -Rpv /home/djwilcox/git/ /zroot/data/git
sudo cp -Rpv /home/djwilcox/.kodi/ /zroot/data/kodi
sudo cp -Rpv /home/djwilcox/.config/ /zroot/data/config
sudo cp -Rpv /home/djwilcox/.emacs.d/ /zroot/data/emacsd
sudo cp -Rpv /home/djwilcox/.local/ /zroot/data/local
sudo cp -Rpv /home/djwilcox/.mozilla/ /zroot/data/mozilla
sudo cp -Rpv /home/djwilcox/.ossuary/ /zroot/data/ossuary
sudo cp -Rpv /home/djwilcox/.weechat/ /zroot/data/weechat
```

we use the -r option for recursive copy  
and the -p option to keep the permissions of the files and directorys  
and the -v option for verbose

we use ~/documents/ to copy the contents of the documents directory  
note the slash at the end of the docuemnts path

#### create the mount points in your home directory

create the zfs mount points

```
zfs set mountpoint=/usr/home/djwilcox/Desktop zroot/data/desktop
zfs set mountpoint=/usr/home/djwilcox/documents zroot/data/documents
zfs set mountpoint=/usr/home/djwilcox/downloads zroot/data/downloads
zfs set mountpoint=/usr/home/djwilcox/git zroot/data/git
zfs set mountpoint=/usr/home/djwilcox/.kodi zroot/data/kodi
zfs set mountpoint=/usr/home/djwilcox/.config zroot/data/config
zfs set mountpoint=/usr/home/djwilcox/.emacs.d zroot/data/emacsd
zfs set mountpoint=/usr/home/djwilcox/.local zroot/data/local
zfs set mountpoint=/usr/home/djwilcox/.mozilla zroot/data/mozilla
zfs set mountpoint=/usr/home/djwilcox/.ossuary zroot/data/ossuary
zfs set mountpoint=/usr/home/djwilcox/.weechat zroot/data/weechat
```

* change the permission on the mountpoint if needed

```
sudo chown -R djwilcox:djwilcox ~/Desktop
```

* chmod the permissions to 700

```
chmod 700 ~/Desktop
```

