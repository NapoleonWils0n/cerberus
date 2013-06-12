#!/bin/bash

# clean pulseaudio config properly:

sudo killall -9 pulseaudio

rm -rf ~/.pulse*

rm -rf /tmp/pulse*

pulseaudio --start