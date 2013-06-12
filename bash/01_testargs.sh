#!/bin/bash
 
IFS="
"
 
echo "COUNT: $#"
echo
echo '\$*'
./00_listargs.sh $*
echo
echo '"\$*"'
./00_listargs.sh "$*"
echo
echo '$@'
./00_listargs.sh $@
echo
echo '"$@"'
./00_listargs.sh "$@"
echo
echo '"foo bar$*bar foo"'
./00_listargs.sh "foo bar$*bar foo"
echo
echo '"foo bar$@bar foo"'
./00_listargs.sh "foo bar$@bar foo"