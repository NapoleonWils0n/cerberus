#!/bin/bash

# sed prepend 127.0.0.1 to file
#==============================

sed -i.bak 's/^/127.0.0.1 /' file.txt