#!/bin/bash

# ffmpeg full non free codecs
#============================

yaourt -S ffmpeg-full



# reinstall to fix misisng libraries

yaourt -Sy fmpeg-full

yaourt -S fmpeg-full