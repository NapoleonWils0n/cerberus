#!/bin/sh


 # =============================
 # = mpeg4ip build install sdl =
 # =============================


./configure
make
sudo make install


# make sybomlic link
# 
# glibtoolize to libtoolize


./bootstrap <params for configure>
./configure --enable-server 
make
sudo make install



# 14.7.8. Remuxing as MP4
# 
# There are several ways to remux AVI files to MP4. You can use mp4creator, which is part of the MPEG4IP suite.
# 
# First, demux the AVI into separate audio and video streams using MPlayer.

mplayer narnia.avi -dumpaudio -dumpfile narnia.aac
mplayer narnia.avi -dumpvideo -dumpfile narnia.h264

# The filenames are important; mp4creator requires that AAC audio streams be named .aac and H.264 video streams be named .h264.
# 
# Now use mp4creator to create a new MP4 file out of the audio and video streams.

mp4creator -create=narnia.aac narnia.mp4
mp4creator -create=narnia.h264 -rate=23.976 narnia.mp4

# Unlike the encoding step, you must specify the framerate as a decimal (such as 23.976), not a fraction (such as 24000/1001).
# 
# This narnia.mp4 file should now be playable with any QuickTime 7 application, such as QuickTime Player or iTunes. If you are planning to view the video in a web browser with the QuickTime plugin, you should also hint the movie so that the QuickTime plugin can start playing it while it is still downloading. mp4creator can create these hint tracks:

mp4creator -hint=1 narnia.mp4
mp4creator -hint=2 narnia.mp4
mp4creator -optimize narnia.mp4

# You can check the final result to ensure that the hint tracks were created successfully:

mp4creator -list narnia.mp4

# You should see a list of tracks: 1 audio, 1 video, and 2 hint tracks.
# 
# Track   Type    Info
# 1       audio   MPEG-4 AAC LC, 8548.714 secs, 190 kbps, 48000 Hz
# 2       video   H264 Main@5.1, 8549.132 secs, 899 kbps, 848x352 @ 23.976001 fps
# 3       hint    Payload mpeg4-generic for track 1
# 4       hint    Payload H264 for track 2



mplayer 2pass.avi -dumpaudio -dumpfile 2pass.mp3
mplayer 2pass.avi -dumpvideo -dumpfile 2pass.h264

mplayer van_tramp.avi -dumpvideo -dumpfile van_tramp.h264

mp4creator -create=van_tramp.aac van_tramp.mp4
mp4creator -create=van_tramp.h264 -rate=25.000 van_tramp.mp4



mp4creator -create=2pass.mp3 out.mp4
mp4creator -create=2pass.h264 -rate=25.000  out.mp4


mp4creator -create=2pass.aac test.mp4
mp4creator -create=2pass.264 -rate=25.00 test.mp4


mp4creator -create=test.aac test.mp4
mp4creator -create=test.h264 -rate=25.000 test.mp4


mplayer -ao pcm -vo null -vc dummy



faac -q 100 -c 48000 -b 128 --mpeg-vers 4 test.aiff


faac -q 100 -c 48000 -b 128 --mpeg-vers 4 -o test.m4a test.aiff