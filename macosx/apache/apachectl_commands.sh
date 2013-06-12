#!/bin/bash

# ====================================
# = Start and stop Apache on the Mac =
# ====================================

sudo apachectl stop 
sudo apachectl configtest 
sudo apachectl start