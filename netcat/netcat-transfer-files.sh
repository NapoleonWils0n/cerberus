#!/bin/bash

# transfer files
nc -l 3333 < backup.iso
nc 192.168.1.5 3333 > backup.iso


# client listen to recieve file
nc -v -w 30 6881 -l > wireshark.pdf

# server sending file
nc -v -w 2 192.168.1.3 6881 > wireshark.pdf
