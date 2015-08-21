#!/bin/bash

# command-line tool for managing and playing television series and films from RSS feeds
#======================================================================================

# install 
yaourt -S magmatv-git

# add feed
magmatv add films public http://magmatv.frangor.info/publicdomain.rss

# update feed
magmatv update public

# list feed
magmatv list public

# play video from feed
magmatv play public 19
