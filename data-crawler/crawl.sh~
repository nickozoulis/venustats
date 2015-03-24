# This script downloads the page with the course's grades.

# Url prefix and suffix, inbetween goes the course's id
URL_PREFIX="http://e-grammateia.aueb.gr/unistudent/courseRelults.asp?dpcID=&orID=&mnuID=mnu5&studpg=&prID=&courseID=92-"
URL_SUFFIX="&isDil="

# Absolute path of the file that contains the courses codes.
ABS_PATH=/var/tmp

# Loop over every course range, obtained from a file.
for C in $(cat ${ABS_PATH}/cource_codes_names | awk '{print $1}')
	do
	# Downloading
	wget ${URL_PREFIX}${C}${URL_SUFFIX}
done
