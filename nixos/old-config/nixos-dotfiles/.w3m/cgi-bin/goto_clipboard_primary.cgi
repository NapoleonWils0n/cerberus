#!/bin/sh

# goto_clipboard_primary.cgi

#GOTO url in clipboard in current page. If the clipboard has a 
#"non url string/nothing" an blank page is shown.
printf "%s\r\n" "W3m-control: GOTO $(xclip -o)";
#delete the buffer (element in history) created between the current page and 
#the searched page by calling this script.
printf "W3m-control: DELETE_PREVBUF\r\n"
