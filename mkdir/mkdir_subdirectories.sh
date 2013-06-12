#!/bin/bash

# mkdir create multiple directories
mkdir -p playground/dir-{00{1..9},0{10..99},100}

# touch create multiple files
touch playground/dir-{00{1..9},0{10..99},100}/file-{A..Z}