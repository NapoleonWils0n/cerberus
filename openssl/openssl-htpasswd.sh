#!/bin/bash

# create an htpasswd for apache authentication with openssl
#==========================================================

# replace username with real username
# replace password with real password


# example
printf "username:$(openssl passwd -apr1 password)\n" >> htpasswd 