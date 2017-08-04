# debian unbound dns server

## install packages

install unbound and dnssec-trigger

```
sudo apt install unbound dnssec-trigger
```
### unbound set up

change directory to the unbound.conf.d directory

```
cd /etc/ubound.conf.d/
```

you should see a custom.conf file
we will back up the custom.conf file and replace it with a new version

back up the custom.conf file

```
sudo mv custom.conf custom.conf.bak
```

* copy new custom.conf file into place

change directory into the /etc/unbound/unbound.conf.d directory in this git repo

```
cd etc/unbound/unbound.conf.d/
```

* copy the custom.conf file to /etc/unbound/unbound.conf.d

```
sudo cp custom.conf /etc/unbound/unbound.conf.d/
```


### dns adblocking

change directory into the /etc/unbound/ directory in this git repo

```
cd etc/unbound/
```

* copy the unbound_ad_servers to /etc/unbound/

```
sudo cp unbound_ad_servers /etc/unbound/
```

#### resolv.conf

we need to edit /etc/resolv.conf and add some code

```
sudo nano /etc/resolv.conf
```

* add the code below to the resolv.conf file

```
nameserver 127.0.0.1
```

the /etc/resolv.conf should only contain the code above

* next we need to write protect the file so it cant be overwritten by the network manager

```
sudo chattr +i /etc/resolv.conf
```

#### dhclient.conf

we need to edit the /etc/dhcp/dhclient.conf file

```
sudo nano /etc/dhcp/dhclient.conf
```

we need to add the code below at the top of the file just below the comment

```
nohook resolv.conf;
```

* the file should look like this

```
# Configuration file for /sbin/dhclient.
#
# This is a sample configuration file for dhclient. See dhclient.conf's
#	man page for more information about the syntax of this file
#	and a more comprehensive list of the parameters understood by
#	dhclient.
#
# Normally, if the DHCP server provides reasonable information and does
#	not leave anything out (like the domain name, for example), then
#	few changes must be made to this file, if any.
#

nohook resolv.conf;
```

##### start unbound

* start unbound dns server

```
sudo systemctl start unbound.service
```

* enable unbound dns server to start at boot

```
sudo systemctl enable unbound.service
```

#### install dnsutils

we need to install dnsutils which will install nslookup
so we can test the local unbound server is being used to lookup domains

* install dnsutils

```
sudo apt install dnsutils
```
* now we use nslookup to look up the dns for google.com using our local dns server

```
nslookup google.com
```

* this should output something like the following

```
Server:		127.0.0.1
Address:	127.0.0.1#53

Non-authoritative answer:
Name:	google.com
Address: 216.58.210.46
```

* you can see the server is 127.0.0.1 which means our unbound dns server is working

#### checking for dns leaks

we want to check our dns server is the only server being used for dns lookups,
so we will a website to check for dnsleaks

go to this website in your browser

[dnsleaktest.com](https://dnsleaktest.com)

click the extended test button
you should see only one dns server listed

this will show your geographic location in the test
so you can see that the dns query are coming from your location

for extra ninja points we want to mask our location by using a vpn

if you use a vpn from somewhere like privateinternetaccess.com 
and then go to the dnsleakstest.com site and run the extended test again you will see your dns now comes out at the vpn endpoint

eg if you connect to a vpn server in the usa your dns will now come out in the usa
