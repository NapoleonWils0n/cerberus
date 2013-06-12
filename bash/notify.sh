#!/bin/bash

# growl notify loop grepping web page

while [ 1 ];
do /usr/local/bin/growlnotify -t "foo" -m "`lynx --dump "http://example.com/stuff" | grep -A 10 -e "text we are looking for" | tail -n 6`"; sleep 10s; done



