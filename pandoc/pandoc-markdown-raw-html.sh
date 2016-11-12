#!/bin/bash

# pandoc markdown strip html
pandoc -f html -t markdown-raw_html -S --normalize --atx-headers -o infile.html outfile.md
