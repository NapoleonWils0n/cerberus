#!/bin/bash

# mplayer headphones internal speakers
#=====================================

mplayer -ao alsa:device=plughw=0 video.mp4
