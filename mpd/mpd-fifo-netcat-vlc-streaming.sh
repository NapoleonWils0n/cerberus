#!/bin/bash

# netcat stream mpd fifo pipe to vlc
#====================================

# server
nc 192.168.1.11 8000 < /tmp/mpdfifo

# linux - dummy interface no gui
cvlc --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 --audio-desync=250 --quiet -I dummy -

# mac osx client - dummy interface no gui
nc -l 8000 | /Applications/VLC.app/Contents/MacOS/VLC --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 --audio-desync=250 --quiet -I dummy -

# mac osx client - macosx interface
nc -l 8000 | /Applications/VLC.app/Contents/MacOS/VLC --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 --audio-desync=250 -I macosx -

