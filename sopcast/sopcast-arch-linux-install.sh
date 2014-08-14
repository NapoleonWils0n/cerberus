#!/bin/bash


# sopcast arch linux install
#============================


# enable multilb for 32 bit applications
#=======================================

# edit /etc/pacman.conf 
# and uncomment the multilib section

sudo vim /etc/pacman.conf

[multilib]
Include = /etc/pacman.d/mirrorlist


# update the package list and upgrade
sudo pacman -Syu


# install sopcast
#================

sudo pacman -S sopcast



# set up mplayer
#===============


# edit the mplayer config file
vim ~/.mplayer/config

# video out
vo=xv

# mplayer use usb audio device for audio
#ao=jack
#ao=alsa:device=plughw=0
ao=alsa:device=plughw=1
prefer-ipv4 = yes
nolirc=yes
really-quiet="1"



# ~/.bashrc sopcast bash functions
#==================================


# sopcast functions
#==================


# sopcast play stream with mplayer
# usage: sopcast-mplayer sop://broker.sopcast.com:3912/143876

sopcast-mplayer () {
(sp-sc "$1" 8901 6881 &>/dev/null &);
sleep 5;
wait $(mplayer -cache 8192 -cache-min 25 http://127.0.0.1:6881);
killall sp-sc;
}

# sopcast play stream with vlc
# usage: sopcast-vlc sop://broker.sopcast.com:3912/143876

sopcast-vlc () {
(sp-sc "$1" 8901 6881 &>/dev/null &);
sleep 5;
wait $(vlc http://127.0.0.1:6881 &>/dev/null);
killall sp-sc;
}

# sopcast save stream with ffmpeg
# usage: sopcast-ffmpeg sop://broker.sopcast.com:3912/143876

sopcast-ffmpeg () {
(sp-sc "$1" 8901 6881 &>/dev/null &);
sleep 5;
wait $(ffmpeg -i http://127.0.0.1:6881 -acodec copy -vcodec copy sopcast-stream.mkv);
killall sp-sc;
}

# sopcast open stream
# usage: sopcast-stream sop://broker.sopcast.com:3912/143876

# stop sopcast, sudo killall sp-sc

# open the firewall to stream on the lan
# sudo iptables -A INPUT -p tcp --dport 6881 -s 192.168.1.0/24 -j ACCEPT

sopcast-stream () {
(sp-sc "$1" 8901 6881 &>/dev/null &);
}


# reload ~/.bashrc to enable the functions
#=========================================


source ~/.bashrc



# xbmc sopcast streaming
#=======================


# create a text file with a .strm extension

# paste in the ip address of your computer and port
# http://192.168.1.12:6881

# in xbmc on your ipad go to videos, files add videos
# click browse and select the home folder click media and then the downloads folder
# click ok and add the downloads folder as a source
# copy the sopcast.strm file with url and port number of sopcast stream on your computer to the downloads folder on the ipad
# just plug the ipad into your linux laptop and it should mount and then you just copy the sopcast.strm file to the downloads folder on the ipad

# in xbmc you should now see the sopcast.strm text file in the downloads source you created
# select the sopcast.strm file and it will open the stream from your other computer and play the stream


