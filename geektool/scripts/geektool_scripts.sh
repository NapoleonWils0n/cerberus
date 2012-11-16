#!/bin/sh


# Show git status

echo "================="
echo "= Cerberus Git Status ="
echo "================="\\n; /usr/bin/git --git-dir=/Users/$USER/Cerberus/.git --work-tree=/Users/$USER/Cerberus status


# Open network connections

echo "======================"
echo "= Open network connections ="
echo "======================"\\n; lsof -i | grep -E "(LISTEN|ESTABLISHED)" | awk '{print $1, $8, $9}'