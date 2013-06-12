#!/bin/bash

# vnc over ssh tunnel
# Use the local port 5901
# so we dont get an error that you cant connect to your own screen


ssh -f -q -L 5901:localhost:5900 80.100.10.4 sleep 10 && open vnc://127.0.0.1:5901