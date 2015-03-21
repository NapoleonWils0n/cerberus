#!/bin/sh
#
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

#  then add an include line to your unbound.conf pointing to the full path of
#  the unbound_ad_servers file:
#
#   include: /var/unbound/etc/unbound_ad_servers


# edit unbound.conf and include link
sudo vim /var/unbound/etc/unbound.conf

include: /var/unbound/etc/unbound_ad_servers



