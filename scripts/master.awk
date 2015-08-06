{

sh format_general.sh -d GRADES_PATH$2 -c CSV_PATH$1 -y YEAR

sh format_bars.sh -d GRADES_PATH$2 -c CSV_PATH$1 -y YEAR

sh format_pies.sh -d GRADES_PATH$2 -c CSV_PATH$1 -y YEAR

}
