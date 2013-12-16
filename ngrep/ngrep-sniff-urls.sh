#!/bin/bash

# ngrep sniff urls
#=================

# To capture all HTTP GET requests to port 80:
sudo ngrep -W byline -qilw 'get' tcp dst port 80


# show only get and host
sudo ngrep -W byline -qilw 'get' tcp dst port 80 | grep -i " -> \|get\|host"
