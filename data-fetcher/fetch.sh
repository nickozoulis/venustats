# This script downloads the page with the course's grades.
# Run as: sh crawl.sh

# Url prefix and suffix, inbetween goes the course's id
URL_PREFIX="http://e-grammateia.aueb.gr/unistudent/courseRelults.asp?dpcID=&orID=&mnuID=mnu5&studpg=&prID=&courseID=92-"
URL_SUFFIX="&isDil="

# The directory where the fetched data will be stored.
OUTPUT_DIR=/var/tmp/venus-stats-data/
# Absolute path of the file that contains the courses codes.
INPUT_DIR=/var/tmp

# Loop over every course range, obtained from a file.
for C in $(cat ${INPUT_DIR}/cource_codes_names | awk '{print $1}')
do
	URL=${URL_PREFIX}${C}${URL_SUFFIX}
	# Downloading
	wget -P ${OUTPUT_DIR} ${URL}
done

# Loop over every file, obtained from a directory.
for FILE in $(ls ${OUTPUT_DIR}*)
do
	# Changing file encoding from Windows-1253 to UTF-8
	iconv -f Windows-1253 -t utf-8 ${FILE} > ${FILE}_
done