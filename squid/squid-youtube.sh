#!/bin/bash

# add to /etc/squid.conf

# block youtube cache servers with squid
acl block_youtube_cache1 dst 173.194.55.0/24
acl block_youtube_cache2 dst 206.111.0.0/16

http_access deny block_youtube_cache1
http_access deny block_youtube_cache2
