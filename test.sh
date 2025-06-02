{
	coproc {
	    while read -sn1 -u3 line # original stdin
	    do
		echo "coproc got $line" >&4 # original stdout
	    done
	}
	} 3<&0 4>&1 # hackery to "ship" stdin and stdout into coprocess
	while sleep 1
	do
	    echo "toplevel doing other things"
	done
