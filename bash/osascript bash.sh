#!/bin/bash

osascript<<EOF
  tell application "Finder"
		activate
		set video to choose file with prompt "select a video to stream"
		set videopath to POSIX path of video
		set videostats to do shell script "file " & quoted form of videopath
		set awkresult to do shell script "echo " & quoted form of videostats & "| awk -F', ' '{print $3,$4,$7}' | awk -F' ' '{print $1,$3,$4,$6}' | awk '{sub(/~/,\"\");print}'"
		set videowidth to first word of awkresult as string
		set videoheight to second word of awkresult as string
		set framerate to third word of awkresult as string
		set audiosamplerate to fourth word of awkresult as string
		set audiobitrate to 128
		set videobitrate to 1000
		set outpath to "/Users/$USER/Sites/video/stream"
  end tell
EOF

