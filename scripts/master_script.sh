#sh master_script.sh -i /var/tmp/test/join_test -y 2013-2014 -g /var/tmp/grades/ -c /var/tmp/csv/
#
#<-- Setting script's external arguments
while getopts ":i:y:g:c:" opt; do
  case $opt in
    i) JOINED_COURSES="$OPTARG"
    ;;	
	y) YEAR="$OPTARG"
    ;;
	g) GRADES_PATH="$OPTARG"
    ;;
	c) CSV_PATH="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
#-->

# With a single awk script, computes all the statistics and refreshes the csv files.
awk -v YEAR="$YEAR" -v GRADES_PATH="$GRADES_PATH" -v CSV_PATH="$CSV_PATH" -f master.awk $JOINED_COURSES
