#!/bin/bash

# grep

find . -name "*.txt" -exec grep -il "lorem" {} \;