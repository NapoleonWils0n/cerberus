# zdb get zpool name from device

get zpool name from a device

```
zdb -l /dev/md0.eli | awk -F\' '/[[:blank:]]name/ {print $2; exit;}'
```
