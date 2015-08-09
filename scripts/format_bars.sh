# Formats the extracted data to proper .csv files (barcharts stats).
# Example run: sh format.sh -d /var/tmp/venus-stats-data/grades/ -c /var/tmp/venus-stats-data/csv/barcharts/ -y 2013-2014

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

# Calculate course's barchart statistics according to examing period and append the current .csv file.
# Use the bars.awk script to format the barchart data.

grep 'ΦΕΒΡ' $DATA > _data.txt
awk -v YEAR="$YEAR" -v SEM="February" -f bars.awk _data.txt >> $CSV

grep 'ΙΟΥΝ' $DATA > _data.txt
awk -v YEAR="$YEAR" -v SEM="June" -f bars.awk _data.txt >> $CSV

grep 'ΣΕΠΤ' $DATA > _data.txt
awk -v YEAR="$YEAR" -v SEM="September" -f bars.awk _data.txt >> $CSV

# Remove any empty lines in the .csv.
sed -i '/^$/d' $CSV

# Remove temporary file.
rm -f _data.txt
