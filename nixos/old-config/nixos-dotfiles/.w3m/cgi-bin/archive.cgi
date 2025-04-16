#!/bin/sh

# archive.org downloads page
# https://archive.org/download/

# current link under cursor in w3m
archive () {
    url="${W3M_CURRENT_LINK}"   
    
    # css selector
    css='div.download-directory-listing'
    
    # output
    wget_output='/tmp/wget-w3m.html'
    output='/tmp/archive.html'
    
    # wget download page and convert links to absolute url
    wget -k "${url}" -O "${wget_output}" 2> /dev/null
    
    # hxnormalize the page
    hxnormalize -x "${wget_output}" | hxselect -s '\n' -c "${css}" > "${output}"
}

# run the archive function
archive

# W3m-control
printf "%s\r\n" "W3m-control: GOTO ${output}";
# delete previous buffer
printf "%s\r\n" "W3m-control: DELETE_PREVBUF";
