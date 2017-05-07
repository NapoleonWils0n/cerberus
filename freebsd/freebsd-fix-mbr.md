# freebsd fix mbr

where device is the boot disk

```
sudo fdisk -B -b /boot/boot0 device
```
