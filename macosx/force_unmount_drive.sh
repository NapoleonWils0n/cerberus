#!/bin/bash

#|------------------------------------------------------------------------------
#|	force unmount drive
#|------------------------------------------------------------------------------

# list /Volumes
ls /Volumes

# force eject the drive
sudo umount -f /Volumes/Turing


# -f = force eject