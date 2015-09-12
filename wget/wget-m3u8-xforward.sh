
# curl record m3u8 videos with x-forward http header
#===================================================


# example url

# http://example.com/hls/live/182235/nbddx/4k296/prog.m3u8|X-Forwarded-For=22.111.222.111



# grep for lines ending in .ts
#===============================

grep -Eo '[a-zA-Z0-9/]*/segment_[0-9]*\.ts$'


grep -E : is the same as egrep
grep -o : only outputs what has been grepped
a-z : is all lower case
A-Z : is all upper case
*: is repeat the [...] group
\.ts$ is search for lines ending in .ts


# delete prog.m3u8 from url to get the directory
sed 's/[a-zA-Z]*\.m3u8$//' 

# grep for line ending in .ts
grep -Eo '[a-zA-Z0-9/]*/segment_[0-9]*\.ts$'

# sed prepend domain to ts links
sed 's#^#http://example.com/hls/live/182235/nbddx/4k296/#'


#!/bin/bash

# wget record m3u8 videos with x-forward http header
#===================================================


# check how many arguments are passed to the script

# if less than 1 arguments are passed to the script, print an error and exit
if [[ $# < 1 ]]
	then
		printf "%b" "error not enough aruments" '\n'
		exit 1 # exit with non zero
# if more than 1 arguments are passed to the script, print an error and exit		
elif [[ $# > 1 ]]
	 then
		printf "%b" "too many aruments" '\n'
		exit 2 # exit with non zero
else

while true 
do
URL=`/usr/bin/cat "$1" | sed "s/^/'/;s/$/'/"`
CookieFileName='/tmp/cookies.txt'
VIDEOURL=`/usr/bin/echo "$URL" | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*\.(m3u8)'`
XFORWARD=`/usr/bin/echo "$URL" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
TSDIR=`/usr/bin/echo "$VIDEOURL" | sed 's/[a-zA-Z]*\.m3u8$//'`
wget -c -U 'Mozilla/5.0' --header="X-Forwarded-For: $XFORWARD" "$VIDEOURL" -O- | grep -Eo '[a-zA-Z0-9/]*/segment_[0-9]*\.ts$' | sed "s#^#$TSDIR/#" | wget -i - --show-progress -U 'Mozilla/5.0' --header="X-Forwarded-For: $XFORWARD" -O- >> "$HOME/Desktop/video.mkv"
done

fi		
