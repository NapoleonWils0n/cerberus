#!/bin/bash

# check to see if script was run as root
#=======================================

if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root"
  exit 1
fi
