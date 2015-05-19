#!/bin/bash


# sed find all local links that dont start with http or end with .domain or .extension
#======================================================================================


sed -n "/http\?s:\/\/\|http:\/\/\|\.[a-z]/! { /href/ s/.*href=['\"]\([^'\"]*\)['\"].*/\1/gp }" file.html