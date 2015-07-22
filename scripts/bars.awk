{
	# Conditions of the bars of the barchart.
	if ($2=="0") arr[1]+=1;
	else if ($2=="0,5") arr[2]+=1;
	else if ($2=="1") arr[3]+=1;
	else if ($2=="1,5") arr[4]+=1;
	else if ($2=="2") arr[5]+=1;
	else if ($2=="2,5") arr[6]+=1;
	else if ($2=="3") arr[7]+=1;
	else if ($2=="3,5") arr[8]+=1;
	else if ($2=="4") arr[9]+=1;
	else if ($2=="4,5") arr[10]+=1;
	else if ($2=="5") arr[11]+=1;
	else if ($2=="5,5") arr[12]+=1;
	else if ($2=="6") arr[13]+=1;
	else if ($2=="6,5") arr[14]+=1;
	else if ($2=="7") arr[15]+=1;
	else if ($2=="7,5") arr[16]+=1;
	else if ($2=="8") arr[17]+=1;
	else if ($2=="8,5") arr[18]+=1;
	else if ($2=="9") arr[19]+=1;
	else if ($2=="9,5") arr[20]+=1;
	else if ($2=="10") arr[21]+=1;
	else ;	
}

# The end block is executed only once, after the last line of the input of the awk script.
END {
	printf "\n";
	#  Print the output in csv format.
	printf YEAR "," SEM;
	# Explicitly insert the zeros (if condition), because their array variables have not been initialized.
	for (i=1; i<=21; i++) {
		if (arr[i]=="") printf ",0"; 
		else printf "," arr[i];
	} 		
}
