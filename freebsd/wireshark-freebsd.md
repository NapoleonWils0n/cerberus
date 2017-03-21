# freebsd wireshark

In order for wireshark be able to capture packets when used by unprivileged
user, /dev/bpf should be in network group and have read-write permissions.
For example:

```
sudo chgrp network /dev/bpf*
sudo chmod g+r /dev/bpf*
sudo chmod g+w /dev/bpf*
```

In order for this to persist across reboots, add the following to
/etc/devfs.conf:

```
sudo chown  bpf* root:network
perm bpf* 0660
```
