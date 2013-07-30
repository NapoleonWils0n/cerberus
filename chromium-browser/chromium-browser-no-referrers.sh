#!/bin/bash

# dont send referrer headers with chrome
# ======================================

# start chromium with the no reffers switch
# =========================================

chromium-browser --no-referrers


# create a bash alias in .bashrc 
# ==============================

# dont send referrer headers with chrome
alias chromium-browser='chromium-browser --no-referrers'
