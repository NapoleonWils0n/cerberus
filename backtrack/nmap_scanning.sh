#!/bin/sh

 # =================
 # = nmap scanning =
 # =================


# scan a machine on the network must be run as root
# 
# os finger print

nmap -O 192.168.0.2 -oG out.txt

cat out.txt


# open nmap file with cat and filter with grep to show open ports


cat out.txt | grep open

cat out.txt | grep open | cut -d " " -f 2 > nmapfile.txt


nmap -O -iL out.txt

nmap -sV -p 22 192.168.1.1/24


# nmap commands
# 
# -sS   syn scan
# 
# -sT  tcp scan
# 
# -sU udp scan
# 
# -p  port scan
# 
# -O operating system scan
# 
# -A services banners and operating system scan
# 
# -vv verbose
# 
# -PO dont ping
# 
# 
# scan all ports
# 
# -p 1-65535
# 
# or scan certain ports
# 
# 
# -p80, 136
# 
# -T5 scan rate (1-5) 5 the fastest
# 
# 
# ping scan

nmap -sP 192.168.0.2

#--------------------------------------------------------------------------------------#

# scan subnet
nmap 192.168.1.*

# Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn
nmap -Pn 192.168.1.*


# nmap scan by -p (port) for windows terminal service
nmap -p 3389 192.168.1.* -oG rdp2.txt

# -p 3389 = port
# -oG write to file and make grepable


nmap -Pn -p 22 192.168.1.* -oG ssh.txt


# -p 22 = port
# -oG write to file


# grep the file to show open ports
cat ssh.txt | grep open

# grep the file to show ports that are up
cat ssh.txt | grep up

# pass grep to cut to extract the ip address
cat ssh.txt | grep open | cut -d " " -f 2 > open.txt

# pass grep to cut to extract the ip address
cat ssh.txt | grep Up | cut -d " " -f 2 > up.txt

# -d " " = delimiter
# -f 2 = second field


# nmap OS fingerprint read from file - requires root permissions so use sudo
sudo nmap -O -iL open.txt

sudo nmap -Pn -O -iL open.txt

# -O = OS fingerprint
# -iL open.txt = read from file


# scan subnet for ports
nmap -sV -p 22 192.168.1.1/24

nmap -Pn -sV -p 22 192.168.1.1/24

# -s = syn scan 
# V = verbose






