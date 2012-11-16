#!/bin/sh

COUNT=0
while [ $COUNT -lt '4' ] ; do
    echo "COUNT IS $COUNT"
    COUNT="$(expr "$COUNT" '+' '1')"
done