#!/bin/bash

# =======================
# = vnc over ssh tunnel =
# =======================

# ip address of computer running ssh
IPADDRESS=192.168.1.2

# vnc over ssh tunnel
ssh -f -q -L 5901:localhost:5900 $IPADDRESS sleep 10 && open vnc://127.0.0.1:5901

# wait 2 secs for screeensharing to open before entering fullscreen
sleep 2

# open screning sharing full screen send output to dev/null
osascript > /dev/null <<EOF
tell application "Screen Sharing"
	activate
end tell
tell application "System Events"
	tell process "Screen Sharing"
		tell menu bar 1
			tell menu bar item "View"
				tell menu "View"
					click menu item "Enter Full Screen"
				end tell
			end tell
		end tell
	end tell
end tell
EOF
