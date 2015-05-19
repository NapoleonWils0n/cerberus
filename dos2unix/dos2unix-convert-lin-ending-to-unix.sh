#!/bin/bash


# dos2unix - convert line ending to unix
#========================================


find . -type f -regex ".*\.\(htm\|html\)$" \
-exec dos2unix '{}' \;
