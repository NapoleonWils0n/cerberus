#!/bin/bash

# sed remove comments and whitespace
#===================================

sed '/ *#/d; /^ *$/d' -i squid.conf
