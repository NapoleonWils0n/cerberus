#!/bin/bash


# pandoc parse raw html - dont strip html elements
find . -type f -regex ".*\.\(htm\|html\)$" -exec pandoc -f html -t markdown --parse-raw -o '{}' '{}' \;
