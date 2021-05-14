#!/bin/sh

# video.cgi

# current link under cursor in w3m
url="${W3M_CURRENT_LINK}"   

# if the current link contains a url pipe it into grep,
# remove the google redirect and decode the url
# if the current link is empty set the url to the page url
if [ ! -z "${url}" ]; then
   result=$(echo "${url}" | \
            grep -oP '(?<=google.com\/url\?q=)[^&]*(?=&)' \
            | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));")
   [ ! -z "${result}" ] && url="${result}" || url="${url}"
else
    url="${W3M_URL}"
fi

# queue the video with taskpooler and play the url with mpv on the current display
#tsp mpv --no-terminal "${url}"

# queue the video with taskpooler and play the url with mpv full screen on the second display
tsp mpv --fs --screen=1 "${url}"

# remove http prefix for notify-send to fix issue with (U) in the notification title
title=$(echo "${url}" | sed -e 's#https\?://\([www.]*\)##g')
notify-send "Queuing ♫" "${title}"

# delete previous buffer
printf "%s\r\n" "W3m-control: BACK";
