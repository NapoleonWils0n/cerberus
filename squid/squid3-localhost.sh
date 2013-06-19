#!/bin/bash

# install squid3 on localhost
sudo apt-get install squid3

# grep squid.conf
grep -ve ^# -ve ^$ squid.conf > squid-grep.conf
