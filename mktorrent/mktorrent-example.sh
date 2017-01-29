#!/bin/bash

mktorrent -v -a udp://tracker.coppersurfer.tk:6969/announce -a udp://tracker.ccc.de:80/announce -a udp://tracker.publicbt.com:80 -a udp://tracker.istole.it:80 -a http://tracker.openbittorrent.com:80/announce -a http://tracker.ipv6tracker.org:80/announce -c "rip-record scripts to record from kodi by NapoleonWils0n windows installer by the t3rmin8or" -n "rip-record-install-1.8.exe" -o rip-record-install-1.8.torrent -w 'https://github.com/t3rmin8tor/kodi-player-core-factory-install/releases/download/v1.8/rip-record-install-1.8.exe' rip-record-install-1.8.exe
