#!/bin/sh

# get dns server

printf "DNS: "; networksetup -getdnsservers Wi-Fi | tr '\n' ' '