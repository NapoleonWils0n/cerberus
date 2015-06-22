#!/bin/bash

# epub fonts and stylesheet and metadata

pandoc --self-contained -s -S --normalize --epub-embed-font='DejaVuSans-*.ttf' --epub-stylesheet=epub.css metadata.yaml -o outfile.epub infile.md 





