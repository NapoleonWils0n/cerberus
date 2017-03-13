# qemu debian

```
sudo apt install qemu-kvm libvirt-daemon bridge-utils netcat-openbsd virt-manager 
```

In order to be able to manage virtual machines as regular user you should put this user into the kvm and libvirt groups:

```
# adduser <youruser> kvm
# adduser <youruser> libvirt
```
