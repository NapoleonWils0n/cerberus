#!/bin/bash

# tshark search for hosts
#========================

tshark -r file.pcap -q -z hosts,ipv4 > tshark-hosts.txt