#<-- Setting script's external arguments
while getopts ":i:" opt; do
  case $opt in
    i) input_dir="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
#-->

#<-- Extract the name of the course and the academic period. They will be used as filenames later.

#-->

#<-- Extract table data from files containing {studentId, grade, semester}
# Foreach file in the input dicectory ending with '_'
for file in ${input_dir}*_
do
	# Extract data using regex and perform some cleansing.
	grep -oP "<?xml(.*)</DIV>" $file | grep -oP "\">?(.*?)</" | awk '{print $2 $3}' | grep -oP ">(.*?)<" | sed 's/[<>]//g' > temp.txt
	# Skip some empty lines in the beginning of the extracted file.
	tail temp.txt -n +5 > ${file}_data.txt	
	# Remove the temporary file used to clean empty lines.
	rm -f temp.txt
done
#-->
