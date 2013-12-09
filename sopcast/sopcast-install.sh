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



# play sopcast stream with mplayer
(sp-sc sop://broker.sopcast.com:3912/143876 8901 9901 &>/dev/null &); sleep 10; wait $(mplayer -cache 8192 http://127.0.0.1:9901); killall sp-sc;

# save sopcast stream with ffmpeg
sp-sc sop://broker.sopcast.com:3912/143876 8901 9901 &>/dev/null &
ffmpeg -i http://127.0.0.1:9901 -acodec copy -vcodec copy sopcast-stream.mkv

# save sopcast stream with tv-maxe

# play sopcast stream with vlc
(sp-sc sop://broker.sopcast.com:3912/143876 8901 9901 &>/dev/null &); sleep 10; wait $(vlc http://127.0.0.1:9901); killall sp-sc;


# sopcast mplayer function for your ~/.bashrc
# source ~/.bashrc
# usage: smplayer sop://broker.sopcast.com:3912/143877
smplayer () {
        (sp-sc "$1" 8901 9901 &>/dev/null &); 
	sleep 10; 
	wait $(mplayer -cache 8192 http://localhost:9901); 
	killall sp-sc;
}

# ~/.mplayer/config
prefer-ipv4 = yes
nolirc=yes



