#!/bin/sh

# from here
# https://community.hpe.com/t5/operating-system-hp-ux/reading-a-single-character-then-what/td-p/2880639

exit=0
command_end=1
while true; do
	stty -echo
	stty raw

	if [ $command_end -eq 1 ]; then
		printf '> '
		command_end=0
	fi

	readchar=$(dd if=$(tty) bs=1 count=1 2>/dev/null)
	# echo -n "$readchar" | xxd
	# printf "%d" "\"$readchar"
	if [ $(printf '%02x' "\"$readchar") = "03" ] || [ $(printf '%02x' "\"$readchar") = "04" ]; then
		exit=1
	elif [ $(printf '%02x' "\"$readchar") = "0d" ]; then
		stty -raw
		command_end=1
		printf "\n"
	elif [ $(printf '%02x' "\"$readchar") = "09" ]; then
		stty -raw
		stty sane
		printf "\b \b"
	else
		stty -raw
		printf "$readchar"
		# echo "$readchar" | head -c1 | xxd
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
