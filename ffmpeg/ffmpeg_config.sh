#!/bin/sh


 # =================
 # = ffmpeg config =
 # =================

svn checkout svn://svn.mplayerhq.hu/ffmpeg/trunk ffmpeg

./configure --enable-gpl --enable-libx264 --enable-libxvid --enable-libfaac --enable-libmp3lame

./configure --prefix-/usr/local --enable-gpl --enable-libx264 --enable-libxvid --enable-libmp3lame

./configure --enable-gpl --enable-libx264 --enable-libxvid --enable-libmp3lame \
--enable-libfaac --enable-libfaad 

# gnumake

/usr/bin/ld: can't locate file for: -lgpac_static