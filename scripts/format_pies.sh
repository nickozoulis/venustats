# Formats the extracted data to proper .csv files (piecharts stats).
# Example run: sh format.sh -i /var/tmp/venus-stats-data/grades/ -o /var/tmp/venus-stats-data/csv/piecharts/ -y 2013-2014

#<-- Setting script's external arguments
while getopts ":d:c:y:" opt; do
  case $opt in
    d) DATA="$OPTARG"
    ;;
	c) CSV="$OPTARG"
    ;;
	y) YEAR="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
#-->

# First erase the 3 older examinations from the .csv (these are the 3 first lines). Only the six newer will be displayed (3 remain and 3 more will be added below).
# @arg: -i -> Makes the changes in the same document.
# @arg: -e -> Erases the specified rows of the file.
# PORTABILITY ISSUE
# -> Ubuntu ships with GNU sed, where the suffix for the -i option is optional. OS X ships with BSD sed, where the suffix is mandatory. Try sed -i ''
sed -i '' -e '1,3d' $CSV
# If the script is executed from Unix, just comment the above and uncomment the below:
#sed -i -e '1,3d' $CSV

# Calculate course's piechart statistics according to examing period and append the current .csv file.
# Cut is used to substring the 2nd and 3rd characters of the grep command, containing the year of entry of the student. (i.e: 310**** -> 10)
# Use the pies.awk script to format the piechart data.

grep 'ΦΕΒΡ' $DATA | cut -c2-3 > _data.txt
awk -v YEAR="$YEAR" -v SEM="February" -f pies.awk _data.txt >> $CSV

grep 'ΙΟΥΝ' $DATA | cut -c2-3 > _data.txt
awk -v YEAR="$YEAR" -v SEM="June" -f pies.awk _data.txt >> $CSV

grep 'ΣΕΠΤ' $DATA | cut -c2-3 > _data.txt
awk -v YEAR="$YEAR" -v SEM="September" -f pies.awk _data.txt >> $CSV

# Delete any empty lines.
# -----------> PORTABILITY ISSUE <-----------
# -> Ubuntu ships with GNU sed, where the suffix for the -i option is optional. OS X ships with BSD sed, where the suffix is mandatory. Try sed -i ''
sed -i '' '/^$/d' $CSV
# If the script is executed from Unix, just comment the above and uncomment the below:
#sed -i '/^$/d' $CSV

# Delete temporary file.
rm -f _data


