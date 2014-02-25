#!/bin/bash


# clvc stream mpd pipe to multicast
cvlc --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 /tmp/mpdfifo --sout "#rtp{dst=239.0.0.1,port=5004,ttl=1}" --sout-keep --network-caching=1000

# clvc stream mpd pipe to multicast as aac
cvlc --demux=rawaud --rawaud-channels 2 --rawaud-samplerate 44100 /tmp/mpdfifo --sout "#transcode{vcodec=none,acodec=mpga,ab=320,channels=2,samplerate=44100}:rtp{dst=239.0.0.1,port=5004,mux=ts,ttl=1}" --sout-keep



