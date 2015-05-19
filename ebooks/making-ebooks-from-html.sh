#!/bin/bash

# converting websites to ebooks and pdfs
#=======================================


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



# strip out just the content to paragraphs
#======================================================================


# find html pages strip out the content re add the html, 
# head and body tags and save the file as html5

find . -type f -regex ".*\.\(htm\|html\)$" |
while read file
do
hxnormalize -x "$file" | \
hxselect -s '\n' -c  \
'html>body>table>tbody>tr>td:nth-of-type(2)>table>tbody>tr:nth-of-type(5)>td>table>tbody>tr>td' | \
pandoc -f html -t html5 --email-obfuscation none --section-divs -s -o "$file"
done


# rename htm files to html if needed
#===============================================================#

find . -type f -regex ".*\.\(htm\)$" |
while read file
do
newname=`echo $file | sed 's/\.\(htm\)/\.html/g'`
mv "$file" "$newname"
done


# change links in htm files so links point to html not htm
#===============================================================#

find . -type f -regex ".*\.\(html\)$" \
-exec sed -i 's/\.\(htm\)/\.html/g' '{}' \;



# find html files and convert to latex
#======================================

find . -type f -regex ".*\.\(htm\|html\)$" \
-exec pandoc -f html -t latex '{}' \
-S -s -N --chapters --normalize --toc --self-contained  -o '{}'.tex \;

# -f html = read html format file
# -t latex = write to latex format
# -S = smart quotes
# -s = standalone, Produce output with an appropriate header and footer
# -N = Number section headings
# --self-contained = self contained
# --toc = create table of contents
# --normalize = remove repeated spaces



# rename tex files to remove .htm and .html from the file name
#=============================================================

find . -type f -regex ".*\.\(htm\|html\)\.tex$" |
while read file
do
newname=`echo $file | sed 's/\.\(htm\|html\)//g'`
mv "$file" "$newname"
done


#===============================================================#

# create pdfs
find . -type f -regex ".*\.tex$" -exec pandoc -f latex '{}' -o '{}'.pdf \;

# make pdfs directory
mkdir -p pdfs

# move pdfs in to pdfs directory
find . -type f -name '*.pdf' -exec mv '{}' pdfs/ \;

#===============================================================#

# create epubs
find . -type f -regex ".*\.tex$" -exec pandoc -f latex -t epub '{}' --toc -o '{}'.epub \;

# make epubs directory
mkdir -p epub

# move epubs in to epub directory
find . -type f -name '*.epub' -exec mv '{}' pdfs/ \;

