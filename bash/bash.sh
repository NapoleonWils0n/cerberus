#!/bin/bash

echo -n "Which color you like the most (red/green/blue)? "
read color

case "$color" in
	red)
		echo You have chosen red
		;;
	green)
		echo You have chosen green
		;;
	blue)
		echo You have chosen blue
		;;
	*)
		echo Invalid option selected
		;;
esac