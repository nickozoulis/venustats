# This awk script will be run foreach line of joined_courses file, each line has two values: the name of the course in greeklish and in greek. These names are necessary to locate the appropriate files in disk.

# Initialize the file hierarchy paths.
BEGIN {
	csv_gen=CSV_PATH"general/";
	csv_bars=CSV_PATH"barcharts/";	
	csv_pies=CSV_PATH"piecharts/";
}

{
	# Concatenate paths with values from joined_courses.	
	grades_path=GRADES_PATH$2"_data.txt";	
	
	csv_path=csv_gen$1".csv";
	system("sh format_general.sh -d " grades_path " -c " csv_path " -y " YEAR);	
	printf("Format General completed: [" $1"]\n");

	csv_path=csv_bars$1".csv";
	system("sh format_bars.sh -d " grades_path " -c " csv_path " -y " YEAR);
	printf("Format Bars completed: [" $1"]\n");

	csv_path=csv_pies$1".csv";
	system("sh format_pies.sh -d " grades_path " -c " csv_path " -y " YEAR);	
	printf("Format Pies completed: [" $1"]\n");	
}
