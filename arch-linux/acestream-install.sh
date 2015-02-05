#!/bin/bash

# acestream install
#==================

yaourt -S acestream-engine acestream-player


# start the acestream engine and specify a port thats open in yout firewall
acestreamengine --client-console --port 6881

# then open a acestream link in the browser
# if you paste the link into the acestream player omit the acestream:// prefix
# or open the acestream player and open a torrent file to stream it

# create a alias for acestreamengine in ~/.bashrc 
alias acestreamengine='acestreamengine --client-console --port 6881'

# reload ~/.bashrc
source ~/.bashrc

# use jack audio out in the ace stream player if you use a usb dac the audio isnt working
