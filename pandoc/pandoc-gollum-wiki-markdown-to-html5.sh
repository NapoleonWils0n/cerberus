#!/bin/bash

# convert gollum wiki markdown to html5
#======================================


find . -type f -regex ".*\.\(md\)$" |
while read file
do
filebasename=`echo $file | sed 's/\.\md/.html/g'`
pandoc -s -f markdown -t html5 -o "$filebasename" "$file"
done


# remove markdown files
#========================================================


# echo files before deleting
find . -type f -regex ".*\.\(md\)$" -exec echo '{}' \;


# delete .md files
find . -type f -regex ".*\.\(md\)$" -exec rm '{}' \;



# sed remove http://mediablends.org.uk/ domain from local links
#==============================================================

find . -type f -regex ".*\.\(htm\|html\)$" \
-exec sed -i 's#http://mediablends.org.uk/##g' '{}' \;



# sed find all local links that dont start with http and add html extension
#==========================================================================

find . -type f -regex ".*\.\(htm\|html\)$" \
-exec sed -i "/http\?s:\/\/\|\.[a-z]/! { /href/ s/.*href=['\"]\([^'\"]*\)/&.html/g }" '{}' \;


