#!/bin/bash

# stream live tv and radio from the BBC
#======================================

# mplayer
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC One" | mplayer -cache 8192 -fs -
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC Two" | mplayer -cache 8192 -fs -
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC Three" | mplayer -cache 8192 -fs -
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC Four" | mplayer -cache 8192 -fs -
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC News" | mplayer -cache 8192 -fs -


# vlc
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC One" | vlc --live-caching=8192 -f - 
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC Two" | vlc --live-caching=8192 -f - 
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC Three" | vlc --live-caching=8192 -f - 
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC Four" | vlc --live-caching=8192 -f - 
get_iplayer --rtmp-livetv-opts --live --stream --type=livetv "BBC News" | vlc --live-caching=8192 -f -  


# radio


get_iplayer --stream --type=liveradio "Radio 1" | vlc --live-caching=8192 -


get_iplayer --stream --type=liveradio "Radio 5 Live" | vlc --live-caching=8192 -

get_iplayer --stream --type=liveradio "Radio 5 Live" | mplayer -cache 8192 -

get_iplayer --stream --type=liveradio "Radio 5 Live" --player="vlc --live-caching=8192 -"

