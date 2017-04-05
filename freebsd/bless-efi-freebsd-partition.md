# bless freebsd efi partition

boot in to mac recovery by pressing option and selecting
disable sips on the mac so we can use the bless comand on the efi partition for freebsd

```
sudo csrutil disable
```

shut the mac
boot into mac osx ,open the terminal

list the disk with diskutil

```
diskutil list
```

switch to root

```
sudo su
```

create a mount point called ESP in /Volumes

```
mkdir /Volumes/ESP
```

mount the efi partition you found by running diskutil list, it will have efi next to the drive

```
mount -t msdos /dev/disk0s1 /Volumes/ESP
```

bless the freebsd efi file

```
bless --mount /Volumes/ESP --setBoot --file /Volumes/ESP/EFI/BOOT/BOOTX64.efi --shortform
```

unmount the /Volume/ESP and the mounted freebsd efi partition

```
umount /Volumes/ESP
```

exit root

```
exit
```
