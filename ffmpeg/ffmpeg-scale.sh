#!/bin/bash

# scale videos with ffmpeg
ffmpeg -i input.mp4 -vf scale=480:-1 output_480.mp4
