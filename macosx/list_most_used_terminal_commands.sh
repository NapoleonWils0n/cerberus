#!/bin/sh

# List Your 15 Most Used Terminal Commands
history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -15