#!/bin/sh

# grep

find . -name "*.txt" -exec grep -il "lorem" {} \;