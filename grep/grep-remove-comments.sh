#!/bin/bash

# grep remove # and white space
# use to reduce the size of squid.conf from 5000 lines to 40 lines
grep -ve ^# -ve ^$ squid.conf > squid-grep.conf
