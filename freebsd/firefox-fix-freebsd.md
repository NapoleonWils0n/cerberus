# firefox fix for freebsd < 11.3

firefox fix for freebsd

## sysctl command

```
sudo sysctl net.local.stream.recvspace=16383
```

### sysctl.conf

edit /etc/sysctl.conf

```
sudo vim /etc/sysctl.conf
```
add the code below to /etc/sysctl.conf

```
net.local.stream.recvspace=16383
```
