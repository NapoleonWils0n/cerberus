#!/bin/bash


# pandoc find markdown files and convert into 1 pdf
#==================================================


pandoc --self-contained -s -S --normalize --toc \
../metadata.yaml \
-o networks.pdf \
$(find . -type f -regex ".*\.md$" -print)




# pandoc find markdown files and convert into 1 epub
#===================================================


pandoc --self-contained -s -S --normalize --toc \
../metadata.yaml \
-o networks.epub \
$(find . -type f -regex ".*\.md$" -print)