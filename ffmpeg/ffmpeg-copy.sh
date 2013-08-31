#!/bin/bash

ffmpeg -i infile.flv -c:v copy -c:a copy outfile.mp4
