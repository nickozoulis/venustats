#! /usr/bin/env bash

#sh master_script.sh -i /Users/nickozoulis/Desktop/tmp/test/join_course_names -y 2013-2014 -g /Users/nickozoulis/Desktop/tmp/grades/ -c /Users/nickozoulis/Desktop/tmp/new_csv/
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
# Computes general, bars and pies.
# @arg: -F -> Sets comma as the delimeter for awk execution.
# @arg: -v -> An input variable to awk.
# @arg: -f -> The awk script to be executed on the file next to .awk (JOINED_COURSES)
awk -F "," -v YEAR="$YEAR" -v GRADES_PATH="$GRADES_PATH" -v CSV_PATH="$CSV_PATH" -f master.awk $JOINED_COURSES

# Compute ranks. 
# @arg: -F -> Sets comma as the delimeter for awk execution.
# @arg: -v -> An input variable to awk.
# @arg: -f -> The awk script to be executed on the file next to .awk (JOINED_COURSES)
awk -F "," -v CSV_PATH="$CSV_PATH" -f ranks.awk $JOINED_COURSES





