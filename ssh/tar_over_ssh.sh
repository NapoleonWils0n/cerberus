#!/bin/bash

tar cvpzf -/ | ssh user@host ""cat > /backup.tar.gz""