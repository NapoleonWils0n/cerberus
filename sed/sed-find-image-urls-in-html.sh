#!/bin/bash

# sed get image urls from html file
#==================================

sed -n 's/.*<img src="\([^"]*\)".*/\1/Ip' index.html

