#!/bin/sh

# 72 hours epg

/usr/bin/curl -s http://www.xmltv.co.uk/feed/6715 -o /home/hts/.xmltv/channels.xmltv && \
/bin/cat /home/hts/.xmltv/channels.xmltv | /usr/bin/socat - UNIX-CONNECT:/home/hts/.hts/tvheadend/epggrab/xmltv.sock
