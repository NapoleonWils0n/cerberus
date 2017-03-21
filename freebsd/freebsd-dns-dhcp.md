# freebsd dhclient

avoid overwriting /etc/resolv.conf

* edit /etc/dhclient-enter-hooks

```
sudo vim /etc/dhclient-enter-hooks
```

add the following to /etc/dhclient-enter-hooks

```
add_new_resolv_conf() {
  # We don't want /etc/resolv.conf changed
  # So this is an empty function
  return 0
}
```
