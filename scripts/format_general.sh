# Formats the extracted data to proper .csv files (general stats).
# Example run: sh format.sh -i /var/tmp/venus-stats-data/grades/ -o /var/tmp/venus-stats-data/csv/general/

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


# Create a temporary file without the last 2 lines(the average grade and percentage) of the file.
wc -l anaptuxh_efarmogwn_plhroforiakwn_susthmatwn.csv | awk '{print $1 - 2}' | xargs -I{} head -n {} anaptuxh_efarmogwn_plhroforiakwn_susthmatwn.csv > _temp_

# Calculate course's statistics according to examing period and append the current .csv file.
grep 'ΦΕΒΡ' data.txt | awk '{if($2>=5){passed+=1};sum+=$2;all+=1} END {printf "'"${YEAR}"'" ",February," all "," passed "," all-passed "," passed*100/all "," "%.2f\n",sum/all}' >> _temp_

grep 'ΙΟΥΝ' data.txt | awk '{if($2>=5){passed+=1};sum+=$2;all+=1} END {printf "'"${YEAR}"'" ",June," all "," passed "," all-passed "," passed*100/all "," "%.2f\n",sum/all}' >> _temp_

grep 'ΣΕΠΤ' data.txt | awk '{if($2>=5){passed+=1};sum+=$2;all+=1} END {printf "'"${YEAR}"'" ",September," all "," passed "," all-passed "," passed*100/all "," "%.2f\n",sum/all}' >> _temp_



# Calculate the new course's percentage-of-success and success-grade-averages.
cat _temp_ > _temp__
awk -F "\"*,\"*"  '{if($3!=0){sumPercentages+=$6;count+=1}} END {printf "%.d\n",sumPercentages/count}' _temp_ >> _temp__
awk -F "\"*,\"*"  '{if($3!=0){sumGrades+=$7;count+=1}} END {printf "%.2f\n",sumGrades/count}' _temp_ >> _temp__

mv _temp__ anaptuxh_efarmogwn_plhroforiakwn_susthmatwn_.csv
rm -f _temp_*







