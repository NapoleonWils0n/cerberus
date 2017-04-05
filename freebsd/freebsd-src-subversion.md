# freebsd checkout src with subversion

install ca_root_nss for ssl certs and subversion

```
sudo pkg install ca_root_nss subversion
```

checkout src to /usr/src

```
sudo svn checkout https://svn.freebsd.org/base/stable/11/ /usr/src
```
