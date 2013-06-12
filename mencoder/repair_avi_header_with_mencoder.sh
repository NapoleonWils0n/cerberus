#!/bin/bash

# ========================================================
# = Use Mencoder to rebuild the header of our avi file.  =
# ========================================================


mencoder -forceidx -oac copy -ovc copy output.avi -o output_final.avi