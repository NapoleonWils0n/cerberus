find . -name "@eaDir" -type d -print |while read FILENAME; do echo "${FILENAME}"; done


find . -name "@eaDir" -type d -print |while read FILENAME; do rm -rf "${FILENAME}"; done