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

# Calculate course's statistics according to examing period and append the current .csv file foreach examination period separately.
# Executes grep and stores the output in a variable so as to check if there is any output.
# If there is no output, the 'then' part will be executed and will print a fixed format.
# If there is any output, the 'else' part will be executed.
grades=$(grep 'ΦΕΒΡ' ${DATA})
if [ $? -eq 1 ]
    then
        printf ${YEAR}",February,0,0,0,0,0.0\n" >> _temp_
    else
      grep 'ΦΕΒΡ' ${DATA} | awk '{if($2>=5){passed+=1;sum+=$2};all+=1} END {printf "'"${YEAR}"'" ",February," all "," passed "," all-passed "," "%d" "," "%.2f\n", passed*100/all, sum/passed}' >> _temp_
fi

grades=$(grep 'ΙΟΥΝ' ${DATA})
if [ $? -eq 1 ]
    then
        printf ${YEAR}",June,0,0,0,0,0.0\n" >> _temp_
    else
      grep 'ΙΟΥΝ' ${DATA} | awk '{if($2>=5){passed+=1;sum+=$2};all+=1} END {printf "'"${YEAR}"'" ",June," all "," passed "," all-passed "," "%d" "," "%.2f\n",passed*100/all, sum/passed}' >> _temp_
fi

grades=$(grep 'ΣΕΠΤ' ${DATA})
if [ $? -eq 1 ]
    then
        printf ${YEAR}",September,0,0,0,0,0.0\n" >> _temp_
    else
      grep 'ΣΕΠΤ' ${DATA} | awk '{if($2>=5){passed+=1;sum+=$2};all+=1} END {printf "'"${YEAR}"'" ",September," all "," passed "," all-passed "," "%d" "," "%.2f\n", passed*100/all, sum/passed}' >> _temp_
fi


# Calculate the new course's percentage-of-success and success-grade-averages. 
# If checks whether there are any students that passed the course. [if($4!=0)]
cat _temp_ > _temp__
awk -F "\"*,\"*"  '{if($4!=0){sumPercentages+=$6;count+=1}} END {printf "%.d\n",sumPercentages/count}' _temp_ >> _temp__
awk -F "\"*,\"*"  '{if($4!=0){sumGrades+=$7;count+=1}} END {printf "%.2f\n",sumGrades/count}' _temp_ >> _temp__

mv _temp__ ${CSV}_.csv
rm -f _temp_*
mv ${CSV}_.csv ${CSV}







