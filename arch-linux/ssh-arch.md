# arch linux ssh server

install openssh 

```
sudo pacman -S openssh
```


### ssh client config

```
vim ~/.ssh/config
```

### copy ssh keys

```
ssh-copy-id user@server
```

### ssh server config

edit the ssh server config file

AllowUsers user
PermitRootLogin no
disable password login
enable ssh public key login


### ssh server iptables

set up iptable rule for ssh


### enable the ssh service

```
sudo systemctl enable sshd.service
```


