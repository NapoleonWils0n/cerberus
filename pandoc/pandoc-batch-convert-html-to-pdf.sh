#/bin/bash

# pandoc create pdf
find . -name '*.html' -exec pandoc -f html {} --toc -o {}.pdf \;

# convert to odt
find . -name '*.htm' -exec pandoc {} --toc --self-contained -o {}.odt \;

# libre office convert odt to pdf
libreoffice --headless --convert-to pdf *.odt

# make pdfs directory
mkdir pdfs

# move pdfs in to pdfs directory
find . -name '*.pdf' -exec mv {} pdfs/ \;

# pandoc create epub
find . -name '*.html' -exec pandoc -f html -t epub {} --toc -o {}.epub \;
