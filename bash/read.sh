#!/bin/sh
printf "Type three numbers separated by 'q'. -> "
IFS="q"
read NUMBER1 NUMBER2 NUMBER3
echo "You said: $NUMBER1, $NUMBER2, $NUMBER3"