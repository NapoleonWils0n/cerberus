#!/bin/bash

# privoxy set up
sudo apt-get install privoxy

# umcomment line 1292 in /etc/privoxy/config to use privoxy with tor
#        forward-socks5   /               127.0.0.1:9050 .


# use chrome proxy switcher, add the following for http, https, socks5
# http proxy: 127.0.0.1 	port: 8118
# https proxy: 127.0.0.1 	port: 8118
# socks host: 127.0.0.1 	port: 8118


# swtich to privoxy in chrome and go to the url below
# http://config.privoxy.org/
