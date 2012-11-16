#!/bin/sh

lynx --source http://example.com/mp3s | grep "mp3" | cut -d\' -f3 | while read mp3; do mplayer "$mp3"; done