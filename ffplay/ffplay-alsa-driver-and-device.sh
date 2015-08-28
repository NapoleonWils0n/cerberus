#!/bin/bash

# export audio driver and device for ffplay
#==========================================

# note we need to use plughw not hw

# export
export SDL_AUDIODRIVER="alsa"
export AUDIODEV="plughw:1,0"

# unset 
unset SDL_AUDIODRIVER
unset AUDIODEV
