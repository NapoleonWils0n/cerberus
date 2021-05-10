#!/bin/sh

# current link under cursor in w3m
url="${W3M_CURRENT_LINK}"   

# if the current link contains a url pipe it into grep,
# remove the google redirect and decode the url
#if the current link is empty set the url to the page url
if [ ! -z "${url}" ]; then
   result=$(echo "${url}" | \
            grep -oP '(?<=google.com\/url\?q=)[^&]*(?=&)' \
            | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));")
   [ ! -z "${result}" ] && url="${result}" || url="${url}"
else
    url="${W3M_URL}"
fi

# W3m-control GOTO url without google redirect
printf "%s\r\n" "W3m-control: GOTO ${url}";

