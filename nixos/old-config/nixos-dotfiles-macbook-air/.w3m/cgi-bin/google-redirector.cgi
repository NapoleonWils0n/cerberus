#!/bin/sh

# current link under cursor in w3m
url="${W3M_CURRENT_LINK}"   

# if the current link contains a url pipe it into grep,
# remove the google redirect and decode the url
#if the current link is empty set the url to the page url
if [ -n "${url}" ]; then
   result=$(echo "${url}" | \
            grep -oP '(?<=google.com\/url\?q=)[^&]*(?=&)' \
            | sed -e "s/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g" | xargs -0 echo -e)
   [ -n "${result}" ] && url="${result}"
else
    url="${W3M_URL}"
fi
