#!/bin/bash

On source computer:

sudo modprobe snd-aloop
arecord -f cd -D hw:Loopback,2,0 | netcat dest 1234
mplayer -ao alsa:device=hw=Loopback.0.0 something.mp3

On destination computer:
netcat -k -l -p 1234 | aplay


snd-aloop index=2 pcm_substreams=2

arecord -D hw:2,0 out.wav
