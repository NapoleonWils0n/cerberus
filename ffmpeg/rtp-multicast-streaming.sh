#!/bin/bash

# ffmpeg rtp multicast streaming
ffmpeg -re -i out.wav -ar 44100 -ac 2 -f s16le -c:a copy -f rtp rtp://239.0.0.1:5004
