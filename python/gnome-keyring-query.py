#!/usr/bin/env python

import sys
import gnomekeyring as gk

if len(sys.argv) > 2:
    ring_name = sys.argv[2]
else:
    ring_name = 'login'

for key in gk.list_item_ids_sync(ring_name):
    item = gk.item_get_info_sync(ring_name, key)
    if item.get_display_name() == sys.argv[1]:
        sys.stdout.write(item.get_secret())
        break
