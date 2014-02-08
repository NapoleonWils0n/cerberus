#!/bin/bash

# transfer files
nc -l 3333 < backup.iso
nc 192.168.1.5 3333 > backup.iso
