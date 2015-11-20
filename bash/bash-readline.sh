#!/bin/bash

[[ $# -eq 0 ]] || exit
CURLINE=1
read -erp "enter a path to your favourites: " FILE
[[ -f $FILE ]] && find $FILE -maxdepth 1 -name '*.xml' -type f \
| while read line;do
        echo "Line # $k: $line"
        ((CURLINE++))
done < $FILE
echo "Total number of lines in file: $k"