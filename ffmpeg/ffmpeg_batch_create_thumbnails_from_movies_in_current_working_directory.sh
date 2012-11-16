#!/bin/sh

 # ===========================================================================
 # = ffmpeg batch create thumbnails from movies in current working directory =
 # ===========================================================================
 

for i in *.mov; do ffmpeg -an -ss 00:00:05 -vframes 1 -y -i "$i" -f image2 -s 128x96 "`echo $i |sed 's/.mov$/.jpg/'`" ;done


# 2nd version


for i in *.mov; do ffmpeg -an -y -t 00:00:10 -i "$i" -f image2 "`echo $i |sed 's/.mov$/.jpg/'`" ;done
