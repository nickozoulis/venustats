# This script downloads the page with the course's grades.
# Example run: sh fetch.sh -i /var/tmp/cource_codes_names -o /var/tmp/

#<-- Setting script's external arguments
while getopts ":i:o:" opt; do
  case $opt in
    i) INPUT="$OPTARG"
    ;;
	o) OUTPUT="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
#-->


# Url prefix and suffix, inbetween goes the course's id
URL_PREFIX="http://e-grammateia.aueb.gr/unistudent/courseRelults.asp?dpcID=&orID=&mnuID=mnu5&studpg=&prID=&courseID=92-"
URL_SUFFIX="&isDil="
# Downloaded file prefix
TEMP_PREFIX="courseRelults.asp?dpcID=&orID=&mnuID=mnu5&studpg=&prID=&courseID=92-"

# The directory where the fetched data will be stored.
DIR="venus-stats-data/"
# A directory is created to store the fetched data.
mkdir ${OUTPUT}${DIR}


# Loop over every course range, obtained from a file.
for C in $(cat ${INPUT} | awk '{print $1}')
do
	URL=${URL_PREFIX}${C}${URL_SUFFIX}
	# Downloading
	wget -P ${OUTPUT}${DIR} ${URL}

	TEMP_FILENAME=${TEMP_PREFIX}${C}${URL_SUFFIX}

	# Get course's name from the file with course codes & names.
	COURSE_NAME=$(grep "${C}" ${INPUT} | sed "s/${C}//g" | xargs | sed "s/ /_/g")

	# Rename the downloaded file.
	mv ${OUTPUT}${DIR}${TEMP_FILENAME} ${OUTPUT}${DIR}${COURSE_NAME}
done


# Loop over every file, obtained from a directory.
for FILE in $(ls ${OUTPUT}${DIR}*)
do
	# Changing file encoding from Windows-1253 to UTF-8
	iconv -f Windows-1253 -t utf-8 ${FILE} > ${FILE}_
	
	rm ${FILE}
	mv ${FILE}_ ${FILE}
done

