#!/bin/bash

# self closing ssh tunnel for afp file sharing

SSHSERVER=80.100.10.4

ssh -f -q -L 1548:localhost:548 $SSHSERVER sleep 60 && open afp://localhost:1548