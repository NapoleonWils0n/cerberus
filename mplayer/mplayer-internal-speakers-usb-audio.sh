#!/bin/bash

# use internal speakers for audio
mplayer -ao alsa:device=hw=0.0 video.avi

# use usb audio for audio
mplayer -ao alsa:device=plughw=1 video.avi
