#!/bin/sh 

# nmap router scanning

# syn scan
sudo nmap -sS 192.168.1.1

# os fingerprint scan
sudo nmap -A 192.168.1.1
