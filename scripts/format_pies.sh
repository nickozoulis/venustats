# Formats the extracted data to proper .csv files (piecharts stats).
# Example run: sh format.sh -i /var/tmp/venus-stats-data/grades/ -o /var/tmp/venus-stats-data/csv/piecharts/ -y 2013-2014

#<-- Setting script's external arguments
while getopts ":i:o:y:" opt; do
  case $opt in
    i) INPUT="$OPTARG"
    ;;
	o) OUTPUT="$OPTARG"
    ;;
	y) YEAR="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
#-->

# Calculate course's piechart statistics according to examing period and append the current .csv file.
# Cut is used to substring the 2nd and 3rd characters of the grep command, containing the year of entry of the student. (i.e: 310**** -> 10)
# Use the pies.awk script to format the piechart data.

grep 'ΦΕΒΡ' $INPUT | cut -c2-3 > _data.txt
awk -v YEAR="$YEAR" -v SEM="February" -f pies.awk _data.txt >> $OUTPUT

grep 'ΙΟΥΝ' $INPUT | cut -c2-3 > _data.txt
awk -v YEAR="$YEAR" -v SEM="June" -f pies.awk _data.txt >> $OUTPUT

grep 'ΣΕΠΤ' $INPUT | cut -c2-3 > _data.txt
awk -v YEAR="$YEAR" -v SEM="September" -f pies.awk _data.txt >> $OUTPUT

# Remove any empty lines in the .csv.
sed -i '/^$/d' $OUTPUT

# Remove temporary file.
rm -f _data.txt

