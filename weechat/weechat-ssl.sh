#!/bin/bash


# weechat ssl
#============

# start weechat

weechat-ncurse


# install ssl plugin
/script install iset.pl


# set
/iset sasl


# add freenode server as ssl
/server add freenode-ssl chat.freenode.net/6697 -ssl
