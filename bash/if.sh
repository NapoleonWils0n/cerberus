#!/bin/bash
 
FIRST_ARGUMENT="$1"
if [ "$FIRST_ARGUMENT" = "Silly" ] ; then
    echo "Silly human, scripts are for kiddies."
else
    echo "Hello, world $FIRST_ARGUMENT!"
fi