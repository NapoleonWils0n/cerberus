#!/bin/bash

# lsof

lsof -i -n -P | grep dropbox

# -i = look for ip sockets
# -n = dont resolve dns
# -P = look at ports


lsof -Pnl -i4
