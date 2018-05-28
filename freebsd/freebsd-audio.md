# freebsd set default audio

view detected audio devices

```
cat /dev/sndstat
```

change to the first audio device

```
sudo sysctl hw.snd.default_unit=1
```

change to the second audio device

```
sudo sysctl hw.snd.default_unit=2
```

# freebsd bit perfect audio 

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

regular audio

```
sudo sysctl dev.pcm.2.bitperfect=0
```

bit perfect

```
sudo sysctl dev.pcm.2.bitperfect=1
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
