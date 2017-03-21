# pf firewall emerging threats

## create /etc/pf.anchors/emerging-threats

```
sudo vim /etc/pf.anchors/emerging-threats
```

add the follow to the file

```
table <emerging_threats> persist file "/etc/emerging-Block-IPs.txt"
block log from <emerging_threats> to any
```

### edit the /etc/pf.conf file

```
sudo vim /etc/pf.conf
```

add the following code to the file

```
anchor "emerging-threats"
load anchor "emerging-threats" from "/etc/pf.anchors/emerging-threats"
```

### download emerging threats text file

```
$ curl http://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -o /tmp/emerging-Block-IPs.txt
$ sudo cp /tmp/emerging-Block-IPs.txt /etc
$ sudo chmod 644 /etc/emerging-Block-IPs.txt
$ sudo pfctl -f /etc/pf.conf
```

### logging

```

$ sudo ifconfig pflog0 create
$ sudo tcpdump -n -e -ttt -i pflog0
```
