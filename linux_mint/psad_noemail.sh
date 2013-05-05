#!/bin/sh

# edit psad.conf and change the ALERTING_METHODS to noemail
sudo vim /etc/psad/psad.conf

ALERTING_METHODS            noemail;
