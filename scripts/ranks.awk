# Initialize the file hierarchy paths.
BEGIN {
	csv_path=CSV_PATH"general/"
	csv_ranks=CSV_PATH"ranks/";

	# Locate the general csv, whose last 2 lines contain grade average and success percentage of the course.	
	rank_average_path=csv_ranks"_ranks_mean_average_grades_success.csv";	
	rank_percentage_path=csv_ranks"_ranks_success_percentage.csv";
}

{	
	csv=csv_path$1".csv";
	
	system("sh format_ranks.sh -i " $3 " -c " csv " -a " rank_average_path " -p " rank_percentage_path);	
}

END {
	# Sort both ranks csvs by second column.
	# @arg: -r -> Reverses the sort output from ascending to descending order.
	# @arg: --field-separator=',' -> Sets the delemiter to be the comma.
	# @arg: --key=2 -> Sorts the file according to 2nd column.
	# @arg: -o -> Sets the sort's output destination. In this case overwrites the old one.
	system("sort -r --field-separator=',' --key=2 -o " rank_average_path " " rank_average_path);
	system("sort -r --field-separator=',' --key=2 -o " rank_percentage_path " " rank_percentage_path);

	# Remove underscores from greek names.
	# @arg: -i: Makes the changes inline (overwrites the old one).
	# PORTABILITY ISSUE, solution from stackoverflow: http://stackoverflow.com/questions/16745988/sed-command-works-fine-on-ubuntu-but-not-mac 
	# -> Ubuntu ships with GNU sed, where the suffix for the -i option is optional. OS X ships with BSD sed, where the suffix is mandatory. Try sed -i ''
	system("sed -i '' 's/_/ /g' " rank_average_path);
	system("sed -i '' 's/_/ /g' " rank_percentage_path);

	# So the script is executed from Unix, just comment the above and uncomment the below:
	#system("sed -i 's/_/ /g' " rank_average_path);
	#system("sed -i 's/_/ /g' " rank_percentage_path);
}
