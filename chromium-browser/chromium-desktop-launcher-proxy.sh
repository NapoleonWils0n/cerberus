#!/bin/bash

# linux desktop launcher for chromium
#========================================================================================

cp /usr/share/applications/chromium-browser.desktop ~/.local/share/applications/chromium-browser.desktop

# edit the chromium-browser.desktop launcher in your home directory
vim ~/.local/share/applications/chromium-browser.desktop

# change line 170 so chromium starts up with the no referrers and disable plugins and use sqiuid proxy
Exec=chromium-browser --no-referrers --disable-plugins --proxy-server=192.168.1.5:3128 %U

