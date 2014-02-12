#!/bin/bash


# save fifo pipe with sox
sox -t raw -e signed-integer -b 16 -c 2 -r 44100 /tmp/mpdfifo out.wav

# play
sox -d -p /tmp/mpdfifo
