#!/bin/bash

WIKI_PATH=/var/wiki
GIT=/usr/bin/git

cd "${WIKI_PATH}"
${GIT} push
sleep 1
${GIT} pull

exit 0