#!/bin/bash

# play raw audio with mplayer
mplayer -demuxer rawaudio -rawaudio format=0x20776172 /tmp/mpdfifo -ao pcm -vo null:file=test.wav

