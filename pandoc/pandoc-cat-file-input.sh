#!/bin/bash

# pandoc cat text file for files to process
#==========================================


# pandoc cat file list for pdf
pandoc --self-contained -s -S --normalize --toc \
~/Desktop/metadata.yaml \
-o outfile.pdf \
$(cat ~/Desktop/file.txt)


# pandoc cat file list for epub
pandoc --self-contained -s -S --normalize --toc \
~/Desktop/metadata.yaml \
-o outfile.epub \
$(cat ~/Desktop/file.txt)


# ~/Desktop/file.txt
file1.md \
file2.md \
file3.md
