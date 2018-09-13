# tor freebsd

install tor

```
sudo pkg install tor
```

run command before starting tor

```
sudo sysctl net.inet.ip.random_id=1
```

start tor

```
sudo service tor onestart
```

stop tor

```
sudo service tor onestop
```
