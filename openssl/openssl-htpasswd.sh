#!/bin/bash

# replace user with username and password with real password

printf "USER:$(openssl passwd -crypt PASSWORD)\n" >> .htpasswd
