#!/bin/bash

# stty dd variant for sh version (unfortunatly not pure version
# https://community.hpe.com/t5/operating-system-hp-ux/reading-a-single-character-then-what/td-p/2880639

exit=0
input=""
command_end=1
while true; do
	if [ $command_end -eq 1 ]; then
		printf '> '
		command_end=0
	fi

	read -rsn1 binput &
	read -rsn1 input
	hexchar=$(printf "%02x" "\"$input") 
	printf "|$hexchar|: "
	hexchar=$(printf "%02x" "\"$binput") 
	printf "|$hexchar|: "
	# printf "|$hexchar|: "
	continue
	if [ $hexchar = "03" ] || [ $hexchar = "04" ]; then
		exit=1
	elif [ $hexchar = "0d" ]; then
		command_end=1
		printf "\n"
	elif [ $hexchar = "7f" ]; then
		printf "\b\033[0J"
	else
		printf "$readchar"
	fi
	if [ $exit -eq 1 ]; then
		echo
		exit 1
	fi
done
exit 0
