#!/bin/bash


# markdown to epub no image figure caption

pandoc -f markdown-implicit_figures --self-contained -s -S --normalize --toc metadata.yaml -o outfile.epub infile.md 


# markdown to pdf no image figure caption

pandoc -f markdown-implicit_figures --self-contained -s -S --normalize --toc metadata.yaml -o outfile.pdf infile.md 
