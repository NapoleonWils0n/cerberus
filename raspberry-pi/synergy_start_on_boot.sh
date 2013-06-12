#!/bin/bash

Making Synergy start automatically on boot

In order to get Synergy to automatically start up I’ve made the file /etc/init.d/synergy which contains the content below.

#! bin/sh
# /etc/init.d/synergy
### BEGIN INIT INFO
# Provides:          synergy
# Required-Start:   
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start synergy daemon at boot time
# Description:       Enable service provided by daemon.
### END INIT INFO
case "$1" in
  start)
    cd /usr/bin/
    su pi -c './synergyc --daemon --name Pi --restart 192.168.1.2'
    echo "Starting synergy client..."
    ;;
  stop)
    pkill synergyc
    echo "Attempting to kill synergy client"
    ;;
  *)
    echo "Usage: /etc/init.d/synergy (start/stop)"
    exit 1
    ;;
esac
exit 0


# Once this file has been created, set the permissions on it so that it can be executed correctly.

sudo chmod 755 /etc/init.d/synergy

update-rc.d synergy defaults

# You’d then want to run the following:

insserv synergy

# You should then be able to run the following commands to start and stop the synergy client.

/etc/init.d/synergy start
/etc/init.d/synergy stop

service synergy stop

service synergy start