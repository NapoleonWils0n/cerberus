#!/bin/bash

sudo apt-get install dante-server



# create a route table named tunnel
#=============================================================

sudo su
echo 200 tunnel >> /etc/iproute2/rt_tables


# Convert the Yoyo.org anti-ad server listing
# into an unbound dns spoof redirection list.

wget -q -O- --header\="Accept-Encoding: gzip" 'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext' | \
gunzip | \
awk '/^127\./{
        print "local-zone: \"" $2 "\" redirect"
        print "local-data: \"" $2 " A 127.0.0.1\""
}' > unbound_ad_servers

# copy unbound_ad_servers to /var/unbound/etc
sudo cp unbound_ad_servers /var/unbound/etc

# change owner to root:_unbound on /var/unbound/etc/unbound_ad_servers
sudo chown root:_unbound /var/unbound/etc/unbound_ad_servers



# start dante socks5 server
#==================================

sudo /lib/systemd/systemd-sysv-install enable danted

sudo systemctl start danted
sudo systemctl stop danted



# vpn script
#==================================

# edit sudoers add user

# copy ~/git/bin/vpn-split-route.sh to /usr/bin/local
