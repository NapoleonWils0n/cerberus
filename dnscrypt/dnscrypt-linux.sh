#!/bin/bash

http://dnscrypt.org/

http://www.webupd8.org/2012/02/encrypt-dns-traffic-in-linux-with.html

##########

https://github.com/jedisct1/libsodium

./configure

make && make check 

sudo su 

make install

#########


https://github.com/opendns/dnscrypt-proxy

./configure

make && make check 

sudo su 

make install


#########

sudo dnscrypt-proxy --local-address=127.0.0.2 --daemonize
