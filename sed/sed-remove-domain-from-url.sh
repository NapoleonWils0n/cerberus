#!/bin/bash


# sed remove http://socialbysocial.net/profiles/blogs/
#=====================================================


sed -i 's#http://socialbysocial.net/profiles/blogs/##g' file.html


find . -type f -regex ".*\.\(htm\|html\)$" \
-exec sed -i 's#http://socialbysocial.net/profiles/blogs/##g' '{}' \;



