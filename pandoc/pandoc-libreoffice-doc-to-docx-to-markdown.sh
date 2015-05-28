#!/bin/bash


# libre office convert doc to docx 
# pandoc convert docx to markdown
#=============================================#



# libreoffice convert doc to docx

libreoffice --convert-to docx --headless infile.doc


# pandoc convert docx to markdown

pandoc -f docx -t markdown -o outfile.md infile.docx



# libreoffice batch convert doc to docx

find . -type f -regex ".*\.\(doc\|DOC\)$" |
while read file
do
libreoffice --convert-to docx --headless "$file" 2>/dev/null
done


# pandoc batch convert docx to markdown

find . -type f -regex ".*\.\docx$" |
while read file
do
filebasename=`echo $file | sed 's/\.\docx/.md/g'`
pandoc -f docx -t markdown -o "$filebasename" "$file"
done

