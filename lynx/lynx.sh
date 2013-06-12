#!/bin/bash

# use lynx to dump page source and grep for http links

lynx --source http://example.com | grep -o 'http://[^"]*'

#-----------------------------------------------#

# get number of search results 
lynx -dump "http://www.google.co.uk/search?q=http://somesite.co.uk" | grep Results | awk -F "of about" '{print $2}' | awk '{print $1}'