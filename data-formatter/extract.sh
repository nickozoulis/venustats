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

#<-- Extract table data from files containing {studentId, grade, semester}
# Foreach file in the input dicectory ending with '_'
for file in ${input_dir}*
do
	# Extract data using regex and perform some cleansing.
	grep -oP "<?xml(.*)</DIV>" $file | grep -oP "\">?(.*?)</" | awk '{print $2 $3}' | grep -oP ">(.*?)<" | sed 's/[<>]//g' > temp
	# Skip some empty lines in the beginning of the extracted file.
	tail temp -n +5 > ${file}_data.txt	
	# Remove the temporary file used to clean empty lines.
	rm -f temp.txt
done
#-->

# Create a directory to store the extracted data.
DIR=${input_dir}"grades/"
mkdir ${DIR}

mv ${input_dir}*_data.txt ${DIR}
