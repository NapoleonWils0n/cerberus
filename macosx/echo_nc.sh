#!/bin/sh
#----------------------------------------------------------------------------------------#
#	Hex over TCP with Echo and Netcat  #
#----------------------------------------------------------------------------------------#

echo -n -e "x01x18x03" | nc 192.168.1.4 80

# The -n supresses outputting the trailing newline.
# The -e enables the interpretation of backslash escapes -- allowing us to send hex codes.