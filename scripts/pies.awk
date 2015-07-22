{
	# Conditions of the pies of the piechart.
	# These conditions should be changed, manually, every year in order to depict the correct results.
	if ($0=="13") arr[1]+=1;
	else if ($0=="12") arr[2]+=1;
	else if ($0=="11") arr[3]+=1;
	else if ($0=="10") arr[4]+=1;
	else arr[5]+=1;	
}

# The end block is executed only once, after the last line of the input of the awk script.
END {
	printf "\n";
	#  Print the output in csv format.
	printf YEAR "," SEM;
		
	for (i=1; i<=5; i++) {
		if (arr[i]=="") printf ",0"; 
		else printf "," arr[i];
	}	
}
