# dnscrypt proxy

```
sudo pacman dnscrypt-proxy
```

### Run as unprivileged user

```
sudo useradd -r -d /var/dnscrypt -m -k /var/empty -s /bin/nologin dnscrypt
```

### Modify the resolv.conf file and replace the current set of resolver addresses with localhost:

```
sudo vim /etc/resolv.conf

nameserver 127.0.0.1
```

### DNSCrypt as a forwarder for local DNS cache

It is recommended to run DNSCrypt as a forwarder for a local DNS cache, otherwise every single query will make a round-trip to the upstream resolver. Any local DNS caching program should work, examples below show configuration for Unbound, dnsmasq, and pdnsd.
First configure dnscrypt-proxy to listen on a port different from the default 53, since the DNS cache needs to listen on 53 and query dnscrypt-proxy on a different port. Port number 40 is used as an example in this section:

### Edit dnscrypt-proxy.service, pointing --user to the new user:

```
sudo systemctl edit dnscrypt-proxy.socket
```

```
[Socket]
ListenStream=
ListenDatagram=
ListenStream=127.0.0.1:40
ListenDatagram=127.0.0.1:40
```

```
sudo systemctl edit dnscrypt-proxy.service
```

```
ExecStart=/usr/bin/dnscrypt-proxy -R dnscrypt.eu-nl --user=dnscrypt
```

# Example: configuration for Unbound

```
sudo vim /etc/unbound/unbound.conf
```

```
do-not-query-localhost: no
forward-zone:
  name: "."
  forward-addr: 127.0.0.1@40
```


```
systemctl daemon-reload
```
