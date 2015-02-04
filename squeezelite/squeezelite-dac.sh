#!/bin/bash

# squeezelite install
yaourt -S squeezelite-git

# squeezelite dac
squeezelite -o iec958:CARD=M192kHz,DEV=0
