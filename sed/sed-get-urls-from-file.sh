#!/bin/bash


# sed get image urls from html file
sed -n 's/.*<img src="\([^"]*\)".*/\1/Ip' index.html > links.html


# sed get image urls from html file and change src to png
cat ideas.htm  | sed -n 's/.*<img src="\([^"]*\)".*/\1/I;s/jpe\?g/png/p'


# quick and dirty search for .jpeg, .jpg, .gif
sed -i 's/\.\(jpe\?g\|gif\)/\.png/I'



