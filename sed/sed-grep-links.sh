#!/bin/bash


grep -oP '(?<=href=")[^"]*(?=")'

sed -n "/href/ s/.*href=['\"]\([^'\"]*\)['\"].*/\1/gp"


cat links.html | grep -o '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' > new.html
