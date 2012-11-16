#!/bin/sh

tar cvpzf -/ | ssh user@host ""cat > /backup.tar.gz""