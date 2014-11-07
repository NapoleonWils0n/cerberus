#!/bin/bash

# 7zip tar.gz
#============


# tar file or directory 
tar zcvf filename.tar.gz filename

# 7zip the tar.gz file
7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on filename.tar.gz.7z filename.tar.gz