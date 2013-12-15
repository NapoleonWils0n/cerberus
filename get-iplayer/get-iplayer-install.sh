#!/bin/bash

# get-iplayer install
#====================

sudo apt-get install get-iplayer


# update get-iplayer tv listing
#==============================

get-iplayer --refresh


# fix rtmp packet error
#======================

get-iplayer --prefs-add --rtmp-tv-opts="--swfVfy http://www.bbc.co.uk/emp/releases/iplayer/revisions/617463_618125_4/617463_618125_4_emp.swf"


# pipe the tv listing into more
#==============================

get-iplayer | more


# search for a programme
#=======================

get-iplayer "likely lads"


# download the video replace 610 with the video id next to the video you want to download
#========================================================================================

get-iplayer -g 1239

# stream the video instead of downloading it and pipe it into mplayer via stdin
#==============================================================================

get-iplayer --stream -g 1239 --tvmode=flashhd,flashvhigh | mplayer -

