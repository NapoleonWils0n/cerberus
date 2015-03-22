#!/bin/bash

# bc - bash calculator
#=====================

# hwo long to crack a wpa key
# 26 characters alpha lower case, 7 character password
# 400 tries a second, 60 seconds an hour, 24 hours
# pipe into bc, bash calculator

echo "26^7/400/60/24" | bc
