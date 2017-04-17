# freebsd set audio device

```
cat /dev/sndstat
```

* internal speakers

```
sysctl hw.snd.default_unit=0
```

* external usb dac

```
sysctl hw.snd.default_unit=2
```
