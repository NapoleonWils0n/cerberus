#!/bin/bash


# converting html to markdown with pandoc
#=========================================


# wget miror website
#====================

wget -m http://makingthenetwork.org


# -m = mirror website



# convert all the images to png
#========================================================

# cd into the website directory
cd makingthenetwork.org

find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)$" -exec convert '{}' '{}.png' \;

# find = find command
# . = current working directory
# -type f = find only file types
# -regex ".*\.\(gif\|jpg\|jpeg\)$" = use a regular expresion to search for .jpg .jpeg .gif
# -exec = execute command 
# convert = imagemagik convert command
# '{}' = original file
# '{}.png' = save file with png extension

# we need to find and convert all the images to png so they work with pandoc



# rename png files to remove .jpg, .jpeg and .gif from the file name
#====================================================================

find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)\.png$" |
while read file
do
newname=`echo $file | sed 's/\.\(jpe\?g\|gif\)//g'`
mv "$file" "$newname"
done



# sed change image urls in html file to png
#====================================================================

find . -type f -regex ".*\.\(htm\|html\)$" \
-exec sed -i 's/\.\(jpe\?g\|gif\)/\.png/Ig' '{}' \;



# remove jpg, gif that arent needed as we converted to png
#========================================================


# echo files before deleting
find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)$" -exec echo '{}' \;

# delete jpg, gifs
find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)$" -exec rm '{}' \;



# html - change only local links in markdown without http https to md extension
#==============================================================================

# change only local links without http https to md extension
sed -i '/http\?s\|http:\/\//! { s/\.\(htm\?l\|htm\)/\.html/Ig }' services.html


# batch convert - find and replace local links to .md
find . -type f -regex ".*\.\html$" \
-exec sed -i '/http\?s\|http:\/\//! { s/\.\(htm\?l\|htm\)/\.md/Ig }' '{}' \;


# convert html to markdown
#=============================================#


find . -type f -regex ".*\.\(htm\|html\)$" |
while read file
do
hxnormalize -x "$file" | \
hxselect -s '\n' -c \
'html>body' | \
tidy -mibq --show-body-only yes --break-before-br yes --drop-empty-paras yes -omit --drop-font-tags yes --tidy-mark no --output-xhtml no | \
sed -e 's/<hr>//g' -e 's/<br>//g' | \
pandoc -f html -t markdown -o "$file"
done


