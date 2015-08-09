# Formats the extracted data to proper .csv files (general stats).
# Example run: sh format.sh -d /var/tmp/venus-stats-data/grades/ -c /var/tmp/venus-stats-data/csv/general/ -y 2013-2014

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


# Create a temporary file without the last 2 lines(the average grade and percentage) of the file.
wc -l ${CSV} | awk '{print $1 - 2}' | xargs -I{} head -n {} ${CSV} > _temp_

# Calculate course's statistics according to examing period and append the current .csv file.
grep 'ΦΕΒΡ' ${DATA} | awk '{if($2>=5){passed+=1};sum+=$2;all+=1} END {printf "'"${YEAR}"'" ",February," all "," passed "," all-passed "," passed*100/all "," "%.2f\n",sum/all}' >> _temp_

grep 'ΙΟΥΝ' ${DATA} | awk '{if($2>=5){passed+=1};sum+=$2;all+=1} END {printf "'"${YEAR}"'" ",June," all "," passed "," all-passed "," passed*100/all "," "%.2f\n",sum/all}' >> _temp_

grep 'ΣΕΠΤ' ${DATA} | awk '{if($2>=5){passed+=1};sum+=$2;all+=1} END {printf "'"${YEAR}"'" ",September," all "," passed "," all-passed "," passed*100/all "," "%.2f\n",sum/all}' >> _temp_



# Calculate the new course's percentage-of-success and success-grade-averages.
cat _temp_ > _temp__
awk -F "\"*,\"*"  '{if($3!=0){sumPercentages+=$6;count+=1}} END {printf "%.d\n",sumPercentages/count}' _temp_ >> _temp__
awk -F "\"*,\"*"  '{if($3!=0){sumGrades+=$7;count+=1}} END {printf "%.2f\n",sumGrades/count}' _temp_ >> _temp__

mv _temp__ ${CSV}_.csv
rm -f _temp_*







