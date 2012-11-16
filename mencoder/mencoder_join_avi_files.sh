#!/bin/sh

# ===========================
# = mencoder join avi files =
# ===========================

# oac - means copy audio codec from original file   
# ovc - means copy video codec  
# o - means output to file with _name_ (joined.avi)  

mencoder -oac copy -ovc copy -o "joined.avi" "1.avi" "2.avi"