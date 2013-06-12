#!/bin/bash

# =================
# = mount webdav  =
# =================

mkdir -p /Users/$USER/webdav

mount_webdav http://server.local./webdav /Users/$USER/Sites/webdav_mount

umount /Users/$USER/Sites/webdav_mount






