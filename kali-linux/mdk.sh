#!/bin/bash

# mdk

cd /pentest/wireless/mdk3

./mdk mon0 -b -n pwned

# mon0 = wlano in monitor mode
# -b = beacon frames 
# -n pwned = network bssid to create 


