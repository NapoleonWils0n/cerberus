tell application "System Events"
	tell current location of network preferences
		set VPNservice to service "VPN Reactor" -- name of the VPN service
		set isConnected to connected of current configuration of VPNservice
		if isConnected then
			disconnect VPNservice
		else
			connect VPNservice
		end if
	end tell
end tell