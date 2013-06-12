#!/bin/bash

for i in *.mov; do ffmpeg -an -ss 00:00:10 -vframes 1 -y -i "$i" -f image2 -s 128x96 "`echo $i |sed 's/.mov$/.jpg/'`" ;done
growlnotify -m "Thumbnails created from mov's" FFMPEG