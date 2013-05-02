#!/bin/sh

 # =======================
 # = vnc over ssh tunnel =
 # =======================


# Local ssh tunnel
ssh -f -q -L 5900:localhost:5900 192.168.1.9 sleep 10 && open vnc://127.0.0.1


# Remote ssh tunnel
ssh -f -q -L 5900:localhost:5900 10.20.30.100 sleep 10 && open vnc://127.0.0.1


# Check for running ssh process
ps ax | grep ssh | grep -v grep


# Kill running ssh process
kill process_id