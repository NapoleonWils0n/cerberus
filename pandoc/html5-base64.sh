#!/bin/bash


# html5 base64

pandoc -t html5 --self-contained -s -S --normalize -o outfile.html infile.md