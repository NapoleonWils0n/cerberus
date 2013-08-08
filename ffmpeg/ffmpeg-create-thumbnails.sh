#!/bin/bash

# ffmpeg save video frame as image
ffmpeg -i input.mp4 -ss 00:00:07 -f image2 -vframes 1 poster.png


