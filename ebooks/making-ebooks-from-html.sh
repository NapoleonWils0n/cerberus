#!/bin/bash

# convert website to ebook
#=========================

# cd to desktop
cd ~/Desktop

# wget miror website
wget -m http://makingthenetwork.org

# -m = mirror website

# k = convert links so they work locally

cd makingthenetwork.org

#===============================================================#

# convert images to png
find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)$" -exec convert '{}' '{}.png' \;


# rename png files to remove .jpg, .jpeg and .gif from the file name

find . -type f -regex ".*\.\(gif\|jpg\|jpeg\)\.png$" |
while read file
do
newname=`echo $file | sed 's/\.\(jpe\?g\|gif\)//g'`
mv "$file" "$newname"
done


#===============================================================#

# sed change image urls in html file to png
find . -type f -regex ".*\.\(htm\|html\)$" -exec sed -i 's/\.\(jpe\?g\|gif\)/\.png/Ig' '{}' \;

#===============================================================#

# markdown --parse-raw html
pandoc -f html -t markdown index.htm --parse-raw --smart --self-contained -o index.markdown
pandoc -f markdown index.markdown -o index.pdf

#===============================================================#
# BeautifulSoup

python

from bs4 import BeautifulSoup

#===============================================================#

# strip out just the content to paragraphs - makingnetwork.org
hxnormalize -x index.htm | \
hxselect -s '\n' -c  \
'html>body>table>tbody>tr>td:nth-of-type(2)>table>tbody>tr:nth-of-type(5)>td>table>tbody>tr>td' > table.htm

#===============================================================#

sed -i 's/<font[^>]*>\s*<\/font>//gpi'

sed -n 's/.*<img src="\([^"]*\)".*/\1/Ip' index.html > links.html


#===============================================================#

## protect fix for image
\subsection{\href{../index.htm}{\emph{\includegraphics{../images/partline.png}}}}
\subsection{\href{../index.htm}{\emph{\includegraphics\protect{../images/partline.png}}}}

# making network fix
file:///Macintosh\%20HD/Web\%20sites/mtnwlatest/images/mtnw-design_02_02.png
../images/mtnw-design_02_02.png

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


