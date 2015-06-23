#!/bin/bash

# convert markdown to html5
#===========================

find . -type f -regex ".*\.\(md\)$" |
while read file
do
filebasename=`echo $file | sed 's/\.\md/.html/g'`
pandoc -s -f markdown -t html5 -o "$filebasename" "$file"
done


# remove original markdown files
#========================================================


# echo files before deleting
find . -type f -regex ".*\.md$" -exec echo '{}' \;

# delete jpg, gifs
find . -type f -regex ".*\.md$" -exec rm '{}' \;



# sed find all local links that dont start with http and add html extension
#==========================================================================


# append .html extension

find . -type f -regex ".*\.\(htm\|html\)$" \
-exec sed -i "/http\?s:\/\/\|\.[a-z]/! { /href/ s/.*href=['\"]\([^'\"]*\)/&.html/g }" '{}' \;


# prepend domain name

find . -type f -regex ".*\.\(htm\|html\)$" \
-exec sed -i "/http\?s:\/\/\|\.[a-z]/! { /href/ s/.*href=['\"]/&http:\/\/mediablends.org.uk/g }" '{}' \;



# convert html to markdown
#========================================

find . -type f -regex ".*\.\(htm\|html\)$" |
while read file
do
filebasename=`echo $file | sed 's/\.\html/.md/g'`
pandoc -f html -t markdown --atx-headers -o "$filebasename" "$file"
done


# remove html5 files
#========================================================


# echo files before deleting
find . -type f -regex ".*\.html$" -exec echo '{}' \;

# delete jpg, gifs
find . -type f -regex ".*\.html$" -exec rm '{}' \;


# convert markdown to pdf
#=============================================================

find . -type f -regex ".*\.md$" |
while read file
do
filebasename=`echo $file | sed 's/\.\md/.pdf/g'`
pandoc --self-contained -s -S -N --normalize --toc -o "$filebasename" "$file"
done


# convert markdown to epub
#=============================================================

find . -type f -regex ".*\.md$" |
while read file
do
filebasename=`echo $file | sed 's/\.\md/.epub/g'`
pandoc --self-contained -s -S -N --normalize --toc -o "$filebasename" "$file"
done


# convert markdown to latex
#========================================

find . -type f -regex ".*\.md$" |
while read file
do
filebasename=`echo $file | sed 's/\.\md/.tex/g'`
pandoc --self-contained -s -S -N --normalize --toc -o "$filebasename" "$file"
done
