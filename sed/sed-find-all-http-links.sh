#!/bin/bash

# sed find all http links 
#========================


sed -n "/href/ s/.*href=['\"]\([^'\"]*\)['\"].*/\1/gp" file.html