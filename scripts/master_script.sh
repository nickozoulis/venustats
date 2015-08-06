#
#
#<-- Setting script's external arguments
while getopts ":i:o:y:" opt; do
  case $opt in
    i) JOINED_COURSES="$OPTARG"
    ;;	
	y) YEAR="$OPTARG"
    ;;
	y) GRADES_PATH="$OPTARG"
    ;;
	y) CSV_PATH="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
#-->

# With a single awk script, computes all the statistics and refreshes the csv files.
awk -v YEAR="$YEAR" -v GRADES_PATH="$GRADES_PATH" -v CSV_PATH="$CSV_PATH" -f master.awk $JOINED_COURSES
