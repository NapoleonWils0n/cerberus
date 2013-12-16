#!/bin/bash

# sniff urls with wireshark
#==========================

# start wireshark as root

gksudo wireshark &

# add a filter for rtmp traffic

rtmpt
