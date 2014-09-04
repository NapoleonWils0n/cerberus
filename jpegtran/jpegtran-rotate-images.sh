#!/bin/bash

# jpegtran rotate images
#=======================

# rotate images by 90 degrees
find . -name "*.JPG" -type f -exec jpegtran -rot 90 -trim -outfile {} {} \; 

# rotate images by 180 degrees
find . -name "*.JPG" -type f -exec jpegtran -rot 180 -trim -outfile {} {} \; 

# rotate images by 270 degrees
find . -name "*.JPG" -type f -exec jpegtran -rot 270 -trim -outfile {} {} \; 