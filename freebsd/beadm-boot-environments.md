# beadm boot environments

freebsd boot environments

## beadm install

```
# pkg install beadm
```

See which boot environments you have.

```
# beadm list
```

The only boot environment is named default. Under active, N means the environment is active now.  
An R means the environment will be active on reboot.

check the current version of freebsd with uname

```
uname -s
```

check for an update

```
# freebsd-update fetch
```

The updates have been downloaded but still haven’t been installed.  
I will prepare a boot environment just in case after installing them something breaks

### create new boot environment

I need to upgrade this host to the latest version of FreeBSD 12.0, p3.  
This is where we need a new boot environment. I’ll name it after the release.

```
# beadm create 12.0-p3
```

list the boot environments

```
# beadm list
```

Activate the new boot environment.

```
# beadm activate 12.0-p3
```

list the boot environments

```
# beadm list
```

While the default environment has an N, indicating it’s active now,
the 12.0-p3 environment has an R, so it will be active after a reboot.

Reboot. After the reboot, you’ll see the new environment is running.

#### install updates in new boot environment

install update in new boot environment

```
# freebsd-update install
```

reboot and run freebsd-update install again

```
# freebsd-update install
```

check for package updates

```
# pkg update
# pkg upgrade
```

create a zfs snapshot

```
zfs snapshot -r zroot@12.0-p3
```
