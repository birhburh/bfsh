#!/bin/sh

# from here
# https://community.hpe.com/t5/operating-system-hp-ux/reading-a-single-character-then-what/td-p/2880639

exit=0
input=""
command_end=1
while true; do
	stty -echo
	stty raw

	if [ $command_end -eq 1 ]; then
		printf '> '
		command_end=0
	fi

	readchar=$(dd if=$(tty) bs=1 count=1 2>/dev/null)
	hexchar=$(printf '%02x' "\"$readchar")
	# printf "|$hexchar|: "
	if [ $hexchar = "03" ] || [ $hexchar = "04" ]; then
		exit=1
	elif [ $hexchar = "0d" ]; then
		stty -raw
		command_end=1
		printf "\n"
	elif [ $hexchar = "7f" ]; then
		stty -raw
		stty sane
		stty erase "^H"
		printf "\b\033[0J"
	else
		stty -raw
		printf "$readchar"
	fi
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
