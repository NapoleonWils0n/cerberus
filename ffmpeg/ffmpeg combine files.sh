#!/bin/sh

# ffmpeg combine seperate audio and video files into a single video


# copy the audio and video tracks
ffmpeg -i audio.aiff -i video.mov -acodec copy -vcodec copy -f mp4 avcombined.mp4

# encode the audio as aac and copy the video track without encoding it. if its the h264 codec
ffmpeg -i audio.aiff -i video.mov -acodec libfaac -ac 2 -ar 48000 -ab 160k -vcodec copy -f mp4 avcombined.mp4