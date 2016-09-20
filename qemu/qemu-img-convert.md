# convert qcow2 to img

```
qemu-img convert -f qcow2 -O raw windows.qcow2 windows.img
```

# convert img and install on external hard drive

```
qemu-img convert -f qcow2 -O raw my-qcow2.img /dev/sdb
```

# in one step

```
qemu-img convert windows.qcow2 -O raw /dev/sdb
```
