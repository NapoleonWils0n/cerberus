#!/bin/bash

# mpd fifo vlc multicast streaming
#=================================


# play fifo pipe from mpd
cvlc --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 /tmp/mpdfifo 

# stream fifo pipe from mpd multicast
cvlc --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 /tmp/mpdfifo --sout "#rtp{dst=239.0.0.1,port=5004,ttl=1}" --sout-keep 

# mac
VLC=/Applications/VLC/Contents/MacOS/VLC -Idummy 
$VLC --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 rtp://239.0.0.1:5004

# multicast rtp stream fifo pipe from mpd
cvlc --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 /tmp/mpdfifo --sout "#transcode{acodec=mp4a,ab=320,channels=2,samplerate=44100}:rtp{dst=239.0.0.1,port=5004,mux=ts,ttl=1}" --sout-keep 


