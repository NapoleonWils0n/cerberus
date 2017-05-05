# bit perfect audio freebsd

list audio devices

```
cat /dev/sndstat
```

set values at boot

```
sudo vim /etc/sysctl.conf
```

edit /etc/sysctl.conf

replace dev.pcm.2 with the number of your audio device

```
dev.pcm.2.play.vchans=0
dev.pcm.2.bitperfect=1
```

show volume

```
mixer
```

set volume

```
mixer -s vol 90:90
mixer -s pcm 90:90
```
