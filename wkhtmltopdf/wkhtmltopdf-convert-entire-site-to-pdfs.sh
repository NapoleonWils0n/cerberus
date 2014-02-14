#!/bin/bash

# download entire site and convert html to pdfs
#==============================================

mkdir /wget
wget --mirror -w 2 -p --html-extension --convert-links -P /wget http://partnerships.org.uk
cd partnerships.org.uk
find . -name '*.html' -exec wkhtmltopdf {} {}.pdf \;
mkdir pdfs
find . -name '*.pdf' -exec mv {} pdfs/ \;
