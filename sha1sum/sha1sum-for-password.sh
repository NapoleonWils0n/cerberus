#!/bin/bash

# create sha1sum for password
#============================

echo -n password | sha1sum | awk '{print $1}'