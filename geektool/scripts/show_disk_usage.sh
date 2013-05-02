#!/bin/sh

# show disk usage

df -hl | grep 'disk1' | awk '{print $4"/"$2" free ("$5" used)"}'