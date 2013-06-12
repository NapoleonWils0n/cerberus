#!/bin/bash

 # ==============================================
 # = Using meld to compare directories over ssh =
 # ==============================================

# Set up a ssh public private key and copy to your server

meld <(ssh 192.168.1.2 ls Desktop) <(ls Desktop)
