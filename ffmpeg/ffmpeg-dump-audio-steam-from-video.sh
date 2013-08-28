#!/bin/bash

# dump audio stream from a video file
ffmpeg -i "$1" -map 0:1 -c copy "$1".m4a
