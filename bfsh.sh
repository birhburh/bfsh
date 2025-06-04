exec 3<&0 4>&1 5< <( 
	while true; do
		IFS= read -rsn4 -u 3 -t1 input
		status=$?
		for (( i=0; i<${#input}; i++ )); do
			printf "%02x" "\"${input:$i:1}"
		done
    	done 
	printf "%02" "\"D"
	printf "%02" "\"O"
	printf "%02" "\"N"
	printf "%02" "\"E"
) 

while true; do
    IFS= read -rsn2 -u5 binput
    # printf "$binput"
    printf "\x$binput"
done

