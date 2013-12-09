#!/bin/bash

# sopcast install
#================

sudo apt-get install ia32-libs

# sp-auth install
wget http://download.easetuner.com/download/sp-auth.tgz
tar -zxvf sp-auth.tgz
sudo cp ./sp-auth/sp-sc-auth /usr/bin/sp-sc
sudo cp ./sp-auth/sp-sc-auth /usr/local/bin/sp-sc

# sopcast player install 
wget http://sopcast-player.googlecode.com/files/sopcast-player-0.8.5.tar.gz
tar -zxvf sopcast-player-0.8.5.tar.gz
cd sopcast-player/

make 
sudo make install

# open port 6881 with iptables if you want to share the sopcast stream on your lan

# play sopcast stream with mplayer
(sp-sc sop://broker.sopcast.com:3912/143876 8901 6881 &>/dev/null &); sleep 10; wait $(mplayer -cache 8192 http://127.0.0.1:6881); killall sp-sc;

# save sopcast stream with ffmpeg
sp-sc sop://broker.sopcast.com:3912/143876 8901 6881 &>/dev/null &
ffmpeg -i http://127.0.0.1:6881 -acodec copy -vcodec copy sopcast-stream.mkv

# save sopcast stream with tv-maxe

# play sopcast stream with vlc
(sp-sc sop://broker.sopcast.com:3912/143876 8901 6881 &>/dev/null &); sleep 10; wait $(vlc http://127.0.0.1:6881); killall sp-sc;


# sopcast mplayer function for your ~/.bashrc
# source ~/.bashrc
# usage: smplayer sop://broker.sopcast.com:3912/143877
smplayer () {
        (sp-sc "$1" 8901 6881 &>/dev/null &); 
	sleep 10; 
	wait $(mplayer -cache 8192 http://localhost:6881); 
	killall sp-sc;
}

# ~/.mplayer/config
prefer-ipv4 = yes
nolirc=yes


# create a text file with a .strm extension
# paste in the zero config address of your computer and port
# http://horus.local:6881
# in xbmc on your ipad go to videos, files add videos
# click browse and select the home folder click media and then the downloads folder
# click ok and add the downloads folder as a source
# copy the sopcast.strm file with url and port number of sopcast stream on your computer to the downloads folder on the ipad
# just plug the ipad into your linux laptop and it should mount and then you just copy the sopcast.strm file to the downloads folder on the ipad
# in xbmc you should now see the sopcast.strm text file in the downloads source you created
# select the sopcast.strm file and it will open the stream from your other computer and play the stream
