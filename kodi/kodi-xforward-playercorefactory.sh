#!/bin/bash


# kodi - ffpmeg x-forward-for record video streams
#==================================================

# format of links we get with the save url command in kodi's play using menu

http://example.com/video.m3u8|X-Forwarded-For=11.111.111.111



# grep http links
#=================

grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" url.txt


grep -E : is the same as egrep
grep -o : only outputs what has been grepped
(http|https) : is an either / or
a-z : is all lower case
A-Z : is all uper case
. : is dot
\?: is ?
*: is repeat the [...] group



# grep x forward for
#=====================

grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' url.txt


# cat file and echo test
#==============================================================

# ffplay code

ffplay -fs \
-headers 'X-Forwarded-For: 11.111.111.111'$'\r\n' \
http://example.com/video.m3u8


ffmpeg \
-headers 'X-Forwarded-For: 11.111.111.111'$'\r\n' \
-i \
http://example.com/video.m3u8 \
-c:v copy -bsf:a aac_adtstoasc -loglevel error \
video-$(date +"%H-%M-%m-%d-%y").mp4


cat url.txt | 
while read url
do
VIDEOURL=`/usr/bin/echo "$url" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*"`
XFORWARD=`/usr/bin/echo "$url" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
/usr/bin/echo -fs -headers 'X-Forwarded-For: '"$XFORWARD"''$'\r\n' "$VIDEOURL"
done


# ffplay x-forward-for
#==================================================


   <player name="ffplay - xforward" type="ExternalPlayer" audio="false" video="true">
		<filename>/usr/bin/echo</filename>
     <args>export SDL_AUDIODRIVER="alsa"; export AUDIODEV="plughw:1,0"; /usr/bin/echo "{0}" | while read url
do
VIDEOURL=`/usr/bin/echo "$url" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*"`
XFORWARD=`/usr/bin/echo "$url" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
/usr/bin/ffplay -fs -headers 'X-Forwarded-For: '"$XFORWARD"''$'\r\n' "$VIDEOURL"
done</args>
     <hidexbmc>true</hidexbmc>
   </player>




# ffmpeg x-forward-for
#==============================================================

   <player name="ffmpeg - xforward" type="ExternalPlayer" audio="false" video="true">
		<filename>/usr/bin/echo</filename>
     <args>"{0}" | while read url
do
VIDEOURL=`/usr/bin/echo "$url" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*"`
XFORWARD=`/usr/bin/echo "$url" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
/usr/bin/ffmpeg -headers 'X-Forwarded-For: '"$XFORWARD"''$'\r\n' -i "$VIDEOURL" -c:v copy -bsf:a aac_adtstoasc -loglevel error "/home/djwilcox/Desktop/video-$(date +"%H-%M-%m-%d-%y").mp4" &
done</args>
     <hidexbmc>false</hidexbmc>
   </player>


# note fix for line endings with ffmpeg and headers: '$'\r\n' 
# note fix for aac audio: -bsf:a aac_adtstoasc


# ffmpeg set recording time - x-forward-for
#==============================================================

   <player name="ffmpeg set recording time - xforward" type="ExternalPlayer" audio="false" video="true">
		<filename>/usr/bin/echo</filename>
     <args>"{0}" | while read url
do
VIDEOURL=`/usr/bin/echo "$url" | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*"`
XFORWARD=`/usr/bin/echo "$url" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
/usr/bin/ffmpeg -headers 'X-Forwarded-For: '"$XFORWARD"''$'\r\n' -i "$VIDEOURL" -c:v copy -bsf:a aac_adtstoasc -loglevel error -t 02:00:00 "/home/djwilcox/Desktop/video-$(date +"%H-%M-%m-%d-%y").mp4" &
done</args>
     <hidexbmc>false</hidexbmc>
   </player>


# note set ffmpeg recording duration with: -t 00:00:00
# format is hours:minutes:seconds

# record 30 minutes: -t 00:30:00
# record 1 hour: -t 01:00:00
# record 2 hours: -t 02:00:00

