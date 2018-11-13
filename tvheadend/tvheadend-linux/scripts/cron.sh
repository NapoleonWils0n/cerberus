#!/bin/sh

/usr/bin/curl -s http://www.xmltv.co.uk/feed/6721 -o /home/hts/.xmltv/channels.xmltv && \
/bin/cat /home/hts/.xmltv/channels.xmltv | /usr/bin/socat - UNIX-CONNECT:/home/hts/.hts/tvheadend/epggrab/xmltv.sock
