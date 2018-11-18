# freebsd pkg export pkg list

export a list of installed packages from one machine

```
pkg noauto > pkg-list.txt 
```

install packages from pkg-list.txt on another machine

```
sudo pkg install -y `cat list`
```
