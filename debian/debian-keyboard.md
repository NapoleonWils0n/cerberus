# debian keyboard

```
sudo dpkg-reconfigure keyboard-configuration
```

## How to set keyboard layout in initramfs

```
sudo vim /etc/initramfs-tools/initramfs.conf
```

```
#
# KEYMAP: [ y | n ]
#
# Load a keymap during the initramfs stage.
#

KEYMAP=y
```

### apply changes

```
sudo update-initramfs -u
```
