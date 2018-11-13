# tvheadend set up

tvheadend pvr

Install Required Packages and add the Repository PGP key

```
sudo apt-get -y install coreutils wget apt-transport-https lsb-release ca-certificates
sudo wget -qO- https://doozer.io/keys/tvheadend/tvheadend/pgp | sudo apt-key add -
```

Create/Add the Sources List

```
sudo sh -c 'echo "deb https://apt.tvheadend.org/stable $(lsb_release -sc) main" | tee -a /etc/apt/sources.list.d/tvheadend.list'
```

Update Sources and Install

```
sudo apt-get update
sudo apt-get install tvheadend
```

Tip: On some installs (generally fresh ones) you might be asked to enter some details.  
If you'd like to reconfigure these details later, you can run.. 

```
sudo dpkg-reconfigure tvheadend
```

start tvheadend

```
sudo service tvheadend restart
```

setting up tvheadend for iptv 


## create scripts directory

```
sudo mkdir -p /home/hts/.hts/tvheadend/scripts
```

* copy shell and python scripts to scripts directory

copy the shell script with ffmpeg pipe commands  
and python scripts for web scraping into the scripts directory

chown the directory recursively to the hts user and video group

```
sudo chown -R hts:video /home/hts/.hts/tvheadend/scripts
```

## iptables


iptables for tvheadend

switch to root

```
sudo su
```

run the commands below to set up iptables  
except the lines that start with the hash symbol which are comments

```
iptables -L
# flush existing rules and set chain policy setting to DROP
iptables -F
iptables -X
# INPUT chain
iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
# tvheadend ports
iptables -A INPUT -p tcp --dport 9881 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 9882 -s 192.168.1.0/24 -j ACCEPT
# ntp time port
iptables -I INPUT -p udp --dport 123 -j ACCEPT
iptables -I OUTPUT -p udp --sport 123 -j ACCEPT
# OUTPUT chain
iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP INVALID " --log-ip-options --log-tcp-options
iptables -A OUTPUT -m state --state INVALID -j DROP
iptables -A OUTPUT -o lo -j ACCEPT
```


### save iptables rules

make sure you are root

switch to root

```
sudo su
```

install iptables-persistent to save iptables rules so they start at boot

```
apt install iptables-persistent
```

save the iptables rules so they are applied at boot time

```
iptables-save > /etc/iptables/iptables.rules
```


if you need to restore the iptables rule  
switch to root first

```
sudo su
```

then restore the iptables rules

```
iptables-restore < /etc/iptables/iptables.rules
```

#### enable iptables

switch to root first

```
sudo su
```

enable iptables to start at boot time

```
systemctl enable iptables
```

start iptables

```
systemctl start iptables
```

reload iptables

```
systemctl reload iptables
```

## tvheadend web ui setup

add a new iptv automatic network

under tv-he configuration, networks tab click the add button
add a new automatic iptv network

file in the Network name as iptv

under url add the path to the m3u

```
file:///home/djwilcox/git/playlists/tv-he.m3u
```

channel numbers from: 1

set channel numbers to start from 1, needed for kodi


install xmltv-utils

```
sudo apt install xmltv-utils socat
```


### tvheadend epg setup

switch to the hts user to set up epg script

```
sudo su hts
```

use whoami to check you are the hts user

```
whoami
```

create .xmltv directory in /home/hts as hts user


```
mkdir p ~/.xmltv
```

download epg xml file


```
curl -s http://www.xmltv.co.uk/feed/6721 -o /home/hts/.xmltv/channels.xmltv
```

import use cat socat unix socket

```
cat /home/hts/.xmltv/channels.xmltv | socat – UNIX-CONNECT:/home/hts/.hts/tvheadend/epggrab/xmltv.sock
```

it should automap the channels to the correct epg entry but you may have to manually map some channels  
after you have mapped all the channels run the above command again to import the data so it shows up in the epg


### cronjob

shell script for cronjob

linux


```
#!/bin/sh

/usr/bin/curl -s http://www.xmltv.co.uk/feed/6721 -o /home/hts/.xmltv/channels.xmltv && \
/bin/cat /home/hts/.xmltv/channels.xmltv | /usr/bin/socat – UNIX-CONNECT:/home/hts/.hts/tvheadend/epggrab/xmltv.sock
```

switch to hts user

```
sudo su hts
```

open hts user crontab

```
crontab -e
```

run cron at 11.30 in the morning every day

```
30 11 * * * /bin/sh /home/hts/.hts/tvheadend/scripts/cron.sh
```


