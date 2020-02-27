#!/bin/bash

# use imagemagik to resize and pad images
convert poster.png -resize 320x180 -background black -gravity center -extent 320x180 out.poster
