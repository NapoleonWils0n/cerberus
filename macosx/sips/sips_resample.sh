#!/bin/sh

# sips resample images 

sips --resampleHeightWidth 100 80 image.png

sips --resampleWidth 80 image.png

sips --resampleHeight 80 image.png

sips --resampleHeightWidthMax 80 80 image.png