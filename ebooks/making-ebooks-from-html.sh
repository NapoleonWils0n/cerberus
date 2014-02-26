#!/bin/bash

# converting websites to ebooks and pdfs
#=======================================


# download the website with wget
#=========================================================

# cd to desktop
cd ~/Desktop

# wget miror website
wget -m http://makingthenetwork.org

# -m = mirror website
# k = convert links so they work locally

# cd into the directory you downloaded with wget
cd makingthenetwork.org


# convert all the images to png
#========================================================

find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)$" -exec convert '{}' '{}.png' \;

# find = find command
# . = current working directory
# -type f = find only file types
# -regex ".*\.\(gif\|jpg\|jpeg\)$" = use a regular expresion to search for .jpg .jpeg .gif
# -exec = execute command 
# convert = imagemagik convert command
# '{}' = original file
# '{}.png' = save file with png extension



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

find . -type f -regex ".*\.\(htm\|html\)$" -exec sed -i 's/\.\(jpe\?g\|gif\)/\.png/Ig' '{}' \;


# strip out just the content to paragraphs - makingnetwork.org
#======================================================================

hxnormalize -x index.htm | \
hxselect -s '\n' -c  \
'html>body>table>tbody>tr>td:nth-of-type(2)>table>tbody>tr:nth-of-type(5)>td>table>tbody>tr>td' > clean-index.htm


# tidy html remove font tags
#=======================================================================

tidy -mibq -omit --doctype omit --drop-font-tags yes --tidy-mark no --show-body-only yes --output-xhtml yes clean-index.htm

# m = modify original file
# i = indent
# b = bare strip quotes
# q = quiet
# -omit = omit optional end tags
# --doctype omit = omit doctype
# --drop-font-tags yes = remove font tags
# --tidy-mark no = dont show tidy text
# --show-body-only yes = only output text between body tags
# --output-xhtml yes = output closing tags

#===============================================================#

# markdown 
pandoc -f html -t markdown clean-index.htm --self-contained -o index.markdown
pandoc -f markdown index.markdown -o index.pdf

#===============================================================#

# find pdfs that are part of the site and save as a list, then exclude from moving so you dont break links

# create pdfs
find . -type f -regex ".*\.\(htm\|html\)$" -exec pandoc -f html '{}' --toc -o '{}'.pdf \;

# make pdfs directory
mkdir -p pdfs

# move pdfs in to pdfs directory
find . -type f -name '*.pdf' -exec mv '{}' pdfs/ \;

#===============================================================#

# create epubs
find . -type f -regex ".*\.\(htm\|html\)$" -exec pandoc -f html -t epub '{}' --toc -o '{}'.epub \;

# make epubs directory
mkdir -p epub

# move epubs in to epub directory
find . -type f -name '*.epub' -exec mv '{}' pdfs/ \;


