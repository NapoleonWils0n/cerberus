#!/bin/bash


# ffplay and ffmpeg add http user agent
#======================================

# example url

http://192.54.104.104:8080/d/mwhzccskpqosuqhy77kmar5tctikmrscw4fxctbfe2g5a4gzxkb7ebxr/video.mp4|User-Agent=Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko&Referer=http://180upload.com/embed-uaqmgcckhpcl.html


# grep http links
#=================


# works search for extension
grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\.(mkv|mp4|m3u8|avi)' url.txt



grep -E : is the same as egrep
grep -o : only outputs what has been grepped
(http|https) : is an either / or
a-z : is all lower case
A-Z : is all uper case
. : is dot
/?: is ?
*: is repeat the [...] group




# user agent
#========================================


grep -Eo 'User-Agent=[a-zA-Z]*/[0-9]{1,1}\.[0-9]{1,1}(.[^&]*)' url.txt


# referer
#========================================

grep -Eo 'Referer=(http|https)://[a-zA-Z0-9./?=_-]*(/|\.html)' url.txt



# cat file test
#========================================

 
# ffplay cat url test
#======================

cat url.txt | 
while read url
do
URL=`/usr/bin/echo "$url" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\.(mkv|mp4|m3u8|avi)'`
USERAGENT=`/usr/bin/echo "$url" | grep -Eo 'User-Agent=[a-zA-Z]*/[0-9]{1,1}\.[0-9]{1,1}(.[^&]*)'`
REFERER=`/usr/bin/echo "$url" | grep -Eo 'Referer=(http|https)://[a-zA-Z0-9./?=_-]*(/|\.html)' | sed 's/Referer=//'`
/usr/bin/echo ffplay -fs -user-agent "$USERAGENT" -headers 'Referer: '"$REFERER"''$'\r\n' "$URL"
done



# ffmpeg cat url test
#======================

cat url.txt | 
while read url
do
URL=`/usr/bin/echo "$url" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\.(mkv|mp4|m3u8|avi)'`
USERAGENT=`/usr/bin/echo "$url" | grep -Eo 'User-Agent=[a-zA-Z]*/[0-9]{1,1}\.[0-9]{1,1}(.[^&]*)'`
REFERER=`/usr/bin/echo "$url" | grep -Eo 'Referer=(http|https)://[a-zA-Z0-9./?=_-]*(/|\.html)' | sed 's/Referer=//'`
/usr/bin/echo ffmpeg -user-agent "$USERAGENT" -headers 'Referer: '"$REFERER"''$'\r\n' -i "$URL" -c:v copy -c:a copy -loglevel error "$HOME/Desktop/video-$(date +"%H-%M-%m-%d-%y").mkv"
done


# wget cat url test
#===================
 
cat url.txt | 
while read url
do
URL=`/usr/bin/echo "$url" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\.(mkv|mp4|m3u8|avi)'`
USERAGENT=`/usr/bin/echo "$url" | grep -Eo 'User-Agent=[a-zA-Z]*/[0-9]{1,1}\.[0-9]{1,1}(.[^&]*)'`
REFERER=`/usr/bin/echo "$url" | grep -Eo 'Referer=(http|https)://[a-zA-Z0-9./?=_-]*(/|\.html)' | sed 's/Referer=//'`
/usr/bin/echo wget -bqc --user-agent="$USERAGENT" --header='Referer: "$REFERER"' "$URL" -O "$HOME/Desktop/video-$(date +"%H-%M-%m-%d-%y").mkv"
done


# ffplay
#=======

URL='http://192.54.104.104:8080/d/mwhzccskpqosuqhy77kmar5tctikmrscw4fxctbfe2g5a4gzxkb7ebxr/video.mp4'
USERAGENT='Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko'
REFERER='http://180upload.com/embed-ewktkejbp6k0.html'



ffplay -fs \
-user-agent "$USERAGENT" \
-headers 'Referer: '"$REFERER"''$'\r\n' \
"$URL"


# ffmpeg
#=======

URL='http://192.54.104.104:8080/d/mwhzccskpqosuqhy77kmar5tctikmrscw4fxctbfe2g5a4gzxkb7ebxr/video.mp4'
USERAGENT='Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko'
REFERER='http://180upload.com/embed-ewktkejbp6k0.html'


ffmpeg \
-user-agent "$USERAGENT" \
-headers 'Referer: '"$REFERER"''$'\r\n' \
-i \
"$URL" \
-c:v copy -c:a copy -loglevel error \
video-$(date +"%H-%M-%m-%d-%y").mkv




# ffplay useragent referer
#===================================

  <player name="ffplay useragent referer" type="ExternalPlayer" audio="false" video="true">
		<filename>/usr/bin/echo</filename>
     <args>export SDL_AUDIODRIVER="alsa"; export AUDIODEV="plughw:1,0"; /usr/bin/echo "{0}" | while read url
do
URL=`/usr/bin/echo "$url" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\.(mkv|mp4|m3u8|avi)'`
USERAGENT=`/usr/bin/echo "$url" | grep -Eo 'User-Agent=[a-zA-Z]*/[0-9]{1,1}\.[0-9]{1,1}(.[^&]*)'`
REFERER=`/usr/bin/echo "$url" | grep -Eo 'Referer=(http|https)://[a-zA-Z0-9./?=_-]*(/|\.html)' | sed 's/Referer=//'`
/usr/bin/ffplay -fs -user-agent "$USERAGENT" -headers 'Referer: '"$REFERER"''$'\r\n' "$URL" 
done</args>
     <hidexbmc>true</hidexbmc>
   </player>


# ffmpeg useragent referer
#===================================

   <player name="ffmpeg useragent referer" type="ExternalPlayer" audio="false" video="true">
		<filename>/usr/bin/echo</filename>
     <args>"{0}" | while read url
do
URL=`/usr/bin/echo "$url" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\.(mkv|mp4|m3u8|avi)'`
USERAGENT=`/usr/bin/echo "$url" | grep -Eo 'User-Agent=[a-zA-Z]*/[0-9]{1,1}\.[0-9]{1,1}(.[^&]*)'`
REFERER=`/usr/bin/echo "$url" | grep -Eo 'Referer=(http|https)://[a-zA-Z0-9./?=_-]*(/|\.html)' | sed 's/Referer=//'`
/usr/bin/ffmpeg -user-agent "$USERAGENT" -headers 'Referer: '"$REFERER"''$'\r\n' -i "$URL" -c:v copy -c:a copy -loglevel error "$HOME/Desktop/video-$(date +"%H-%M-%m-%d-%y").mkv" &
done</args>
     <hidexbmc>false</hidexbmc>
   </player>



# wget useragent referer
#===================================


   <player name="wget useragent referer" type="ExternalPlayer" audio="false" video="true">
		<filename>/usr/bin/echo</filename>
     <args>"{0}" | while read url
do
URL=`echo "$url" | grep -Eo '(http|https)://[a-zA-Z0-9:0-9./?=_-]*\.(mkv|mp4|m3u8|avi)'`
USERAGENT=`echo "$url" | grep -Eo 'User-Agent=[a-zA-Z]*/[0-9]{1,1}\.[0-9]{1,1}(.[^&]*)'`
REFERER=`echo "$url" | grep -Eo 'Referer=(http|https)://[a-zA-Z0-9./?=_-]*(/|\.html)' | sed 's/Referer=//'`
/usr/bin/wget -bqc --user-agent="$USERAGENT" --header="Referer: $REFERER" "$URL" -O "$HOME/Desktop/video-url-$(date +"%m-%d-%y-%H-%M").mkv" 
done</args>
     <hidexbmc>false</hidexbmc>
   </player>
