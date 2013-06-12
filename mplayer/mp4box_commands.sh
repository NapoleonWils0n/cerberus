#!/bin/bash

 # ===================
 # = mp4box commands =
 # ===================


MP4Box -fps 25.00 -add chapter_20.h264 -add chapter_20.mp3 out.mp4

MP4Box -add chapter_20.h264 -add chapter_20.mp3 -fps 25.00 out.mp4