#!/bin/bash

# strip out the content from a single page
hxnormalize -x index.htm | \
hxselect -s '\n' -c  \
'html>body>table>tbody>tr>td:nth-of-type(2)>table>tbody>tr:nth-of-type(5)>td>table>tbody>tr>td' > clean-index.htm

# find html pages strip out the content re add the html, head and body tags and save the file as html5
find . -type f -regex ".*\.\(htm\|html\)$" |
while read file
do
hxnormalize -x "$file" | \
hxselect -s '\n' -c  \
'html>body>table>tbody>tr>td:nth-of-type(2)>table>tbody>tr:nth-of-type(5)>td>table>tbody>tr>td' | \
tidy -mibq --doctype strict --drop-font-tags yes --tidy-mark no --output-xhtml yes -o "$file"
done


# find html pages strip out the content re add the html, head and body tags and save the file as html5
find . -type f -regex ".*\.\(htm\|html\)$" |
while read file
do
hxnormalize -x "$file" | \
hxselect -s '\n' -c  \
'html>body>table>tbody>tr>td:nth-of-type(2)>table>tbody>tr:nth-of-type(5)>td>table>tbody>tr>td' | \
pandoc -f html -t html5 --email-obfuscation none --section-divs --self-contained -o "$file"
done

