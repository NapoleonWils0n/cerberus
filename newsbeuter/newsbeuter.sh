#!/bin/bash

# newsbeuter rss ncurses rss reader
#==================================

# install newsbeuter
sudo pacman -S newsbeuter

# create the directory ~/.newsbeuter/
mkdir -p ~/.newsbeuter

# create the file ~/.newsbeuter/urls
touch ~/.newsbeuter/urls

# create the file ~/.newsbeuter/config
touch ~/.newsbeuter/config


# edit ~/.newsbeuter/config

# set the browser
# if you subscribe to a youtube channel and you would like to open the video with mpv, 
# add the macro, to use a macro, you must first press the , key, 
# followed by the keybind. In the example above, you would type , + y


vim  ~/.newsbeuter/config

auto-reload yes
browser "/usr/bin/chromium %u"
macro y set browser "/usr/bin/mpv %u"; open-in-browser ; set browser "/usr/bin/chromium %u"


# you have to add one feed before starting up newsbeuter, either in  ~/.newsbeuter/urls
# or by starting newsbeuter with -i and then the url, for example
# newsbeuter -i http://example.com/feed.rss

# start newsbeuter
newsbeuter 

# clean cache
newsbeuter -X

