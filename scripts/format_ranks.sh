#sh format_ranks.sh -i /var/tmp/test/rank_courses_joined -c /var/tmp/csv/general/{course_name.csv} -a /var/tmp/csv/ranks/ranks_mean_average_grades_success.csv -p /var/tmp/csv/ranks/ranks_success_percentage.csv
#
#<-- Setting script's external arguments
while getopts ":i:c:a:p:" opt; do
  case $opt in
    i) COURSE_NAME="$OPTARG"
    ;;
	c) CSV_PATH="$OPTARG"
    ;;		
	a) AVERAGE_GRADES="$OPTARG"
    ;;
	p) SUCCESS_PERCENTAGES="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
#-->


# Takes the last line of the general csv (grade average) and appends the ranks csv with it's greek name.
tail -n 1 $CSV_PATH | xargs -I{} printf $COURSE_NAME","{}"\n" >> $AVERAGE_GRADES

# Takes the line-before-the last of the general csv (success percentage) and appends the ranks csv with it's greek name.
tail -n 2 $CSV_PATH | head -1 | xargs -I{} printf $COURSE_NAME","{}"\n" >> $SUCCESS_PERCENTAGES

