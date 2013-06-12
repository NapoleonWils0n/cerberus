#!/bin/bash

for i in *.mp4; do ffmpeg -an -ss 00:00:10 -vframes 1 -y -i "$i" -f image2 -s 128x96 "`echo $i |sed 's/.mp4$/.jpg/'`" ;done
growlnotify -m "Thumbnails created from mp4's" FFMPEG
	