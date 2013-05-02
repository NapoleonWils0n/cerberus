#!/bin/sh

 # ===============================
 # = diff compare files over ssh =
 # ===============================


diff <(find /Users/$USER/code) <(ssh -n 192.168.1.9 find /Users/$USER/code) > out.txt

diff -y <(find /Users/$USER/code) <(ssh -n 192.168.1.9 find /Users/$USER/code) > out.txt
