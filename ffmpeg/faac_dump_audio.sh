#!/bin/bash

 # ===================
 # = faac dump audio =
 # ===================


faac -q 100 -P -R 48000 -b 128 2pass.aiff 


# 44100


faac -q 100 -P -R 44100 -b 128 2pass.aiff 


# name out put file


faac -q 100 -P -R 48000 -b 128 -o test.aac 2pass.aiff 


# create m4a


faac -q 100 -P -R 48000 -b 128 -w 2pass.aiff 


faac -q 100 -P -R 44100 -b 128 --mpeg-vers 4 -o test.aac 2pass.aiff 


faac -m 4 -o LC q 100 -P -R 48000 -b 128 2pass.aiff 


faad -a out.aac 2pass.aac





