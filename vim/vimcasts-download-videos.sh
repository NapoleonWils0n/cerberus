#!/bin/bash

# download vimcast videos
#========================

for (( c=1; c<=68; c++ )); do file=$(curl -s http://media.vimcasts.org/videos/$c/ | grep m4v | sed 's/.*m4v\">\(.*m4v\)<\/a>.*/\1/g'); url=http://media.vimcasts.org/videos/$c/$file; echo $url; curl -C - -# -o "$c-$file" "$url"; done
