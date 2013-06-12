#!/bin/bash

# to flush the DNS cache in Mac OS X 10.5 and 10.6, run this command in Terminal: 
sudo dscacheutil -flushcache 

# To do the same in 10.7 and 10.8, run this command: 
sudo killall -HUP mDNSResponder 

