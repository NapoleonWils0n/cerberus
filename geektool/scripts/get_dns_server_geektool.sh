#!/bin/bash

# get dns server

printf "DNS: "; networksetup -getdnsservers Wi-Fi | tr '\n' ' '