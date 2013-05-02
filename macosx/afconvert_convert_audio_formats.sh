#!/bin/sh

 # ===================================
 # = afconvert convert audio formats =
 # ===================================


# Text to audio

say -f infile.txt -o outfile.aiff


# Converting audio


afconvert -v -f "m4af" -d "aac@22050" -c 1 -b 64000 -q 127 --soundcheck-generate infile.aiff

afconvert -v -f "mp4f" -d "aac@44100" -c 2 -b 128000 -q 127 -s 3 --soundcheck-generate infile.aiff


# AtomicParsley

AtomicParsley infile.m4a --title "Making the best of the Big Society debate" --artist "David Wilcox" --copyright "David Wilcox" --genre "Socialreporter" --year "2010" --artwork infile.jpg


# mplayer


mplayer van\ tramp.mov -ao pcm -vo null:file=test.wav 

