# netcat send and recieve files

send and recieve files with netcat 

* recieving computer

replace 6881 with the port of your choice  
and make sure the port is open in your firewall on the recieving computer

```
nc -lv 6881 > outfile.txt
```

* sending sending computer

replace 192.168.1.3 with the ip address of the recieving computer

```
nc -w 3 192.168.1.3 6881 < infile.txt
```
