# Formats the extracted data to proper .csv files (barcharts stats).
# Example run: sh format.sh -i /var/tmp/venus-stats-data/grades/ -o /var/tmp/venus-stats-data/csv/barcharts/ -y 2013-2014

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

# Calculate course's barchart statistics according to examing period and append the current .csv file.
# Use the bars.awk script to format the barchart data.

grep 'ΦΕΒΡ' $INPUT > _data.txt
awk -v YEAR="$YEAR" -v SEM="February" -f bars.awk _data.txt >> $OUTPUT

grep 'ΙΟΥΝ' $INPUT > _data.txt
awk -v YEAR="$YEAR" -v SEM="June" -f bars.awk _data.txt >> $OUTPUT

grep 'ΣΕΠΤ' $INPUT > _data.txt
awk -v YEAR="$YEAR" -v SEM="September" -f bars.awk _data.txt >> $OUTPUT

# Remove any empty lines in the .csv.
sed -i '/^$/d' $OUTPUT

# Remove temporary file.
rm -f _data.txt