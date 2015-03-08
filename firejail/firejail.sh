#!/bin/bash

# firejail
#=========


# install from the aur

yaourt -S firejail


# run firejail with --seccomp to sandbox firefox

firejail --seccomp firefox
