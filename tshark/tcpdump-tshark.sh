#!/bin/bash

# tcpdump capture traffic from host
#===================================


# tcpdump capture traffic
#=========================

sudo tcpdump -s 0 host 192.168.1.3 -i ens9 -w ens9.pcap

# tshark find http links
#=========================

tshark -r ens9.pcap -T fields -e http.host -e http.request.uri -Y 'http.request.method == "GET"' \
| sort | tr -d " \t\r" | sed 's#^#http://#' \
| grep -Ev '(http|https)://[a-zA-Z0-9./?=_@%-]*\.(md5|jpg|png)' > links.txt


# wget download links
#=========================

wget -i links.txt

