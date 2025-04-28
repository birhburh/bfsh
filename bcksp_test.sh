#!/bin/sh

# from here
# https://community.hpe.com/t5/operating-system-hp-ux/reading-a-single-character-then-what/td-p/2880639

exit=0
command_end=1
while true; do
	stty -echo
	# stty raw

	if [ $command_end -eq 1 ]; then
		printf '> '
		command_end=0
	fi


	read input
	echo $input
	command_end=1
	stty -raw
	stty sane
	stty erase "^H"
	if [ $exit -eq 1 ]; then
		echo
		stty sane
		exit 1
	fi
done
exit 0
