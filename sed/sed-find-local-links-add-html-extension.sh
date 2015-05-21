#!/bin/bash


# sed find all local links that dont start with http and add html extension
#==========================================================================


sed -i "/http\?s:\/\/\|\.[a-z]/! { /href/ s/.*href=['\"]\([^'\"]*\)/&.html/g }" index.html 

