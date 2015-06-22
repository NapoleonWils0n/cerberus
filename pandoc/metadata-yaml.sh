#!/bin/bash


# markdown to pdf with metadata yaml file

pandoc --self-contained -s -S --normalize --toc metadata.yaml -o outfile.pdf infile.md 