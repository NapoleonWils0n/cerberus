#!/bin/sh

# ping with date stamp

# store date as a variable
echo $(date +%F_%T)

# create a while loop with date and ping
ping 8.8.8.8 | while read pong; do echo "$(date +%F_%T) -- $pong"; done
