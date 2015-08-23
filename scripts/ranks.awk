# Initialize the file hierarchy paths.
BEGIN {
	csv_path=CSV_PATH"general/"
	csv_ranks=CSV_PATH"ranks/";

	# Locate the general csv, whose last 2 lines contain grade average and success percentage of the course.	
	rank_average_path=csv_ranks"ranks_mean_average_grades_success.csv";	
	rank_percentage_path=csv_ranks"ranks_success_percentage.csv";
}

{	
	csv=csv_path$1".csv";

	system("sh format_ranks.sh -i " $3 " -c " csv " -a " rank_average_path " -p " rank_percentage_path);	
}

END {
	# Sort both ranks csvs by second column and overwrite.
	system("sort -t \",\" -nr -k2,2 -o " rank_average_path " " rank_average_path);
	system("sort -t \",\" -nr -k2,2 -o " rank_percentage_path " " rank_percentage_path);

	# Remove underscores from greek names.
	system("sed -i 's/_/ /g' " rank_average_path);
	system("sed -i 's/_/ /g' " rank_percentage_path);
}
