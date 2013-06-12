#!/bin/bash

# create video from audio and image

ffmpeg -i audio.m4a -i picture.png -f mov out.mov