create_year_file()
{
   INPUT_FILE=$1 	#CSV File
   NEIGHBOURHOOD=$2	#Paris Neighbourhood
   C1=$3		#Column number (csvcut -n [csv file])
   C2=$4
   C3=$5
   C4=$6
   C5=$7
   C6=$8
   OUTPUT_FILE=$9	#gnuplot and json data filename

   echo "Cutting csv original file to accomodate only columns of interest..."
   csvcut -c $C1,$C2,$C3,$C4,$C5,$C6 $INPUT_FILE > few_columns.csv

   echo "Removing entries with O or no square feet and beds information..."
   csvsql --query "select * from few_columns where square_feet!='' and square_feet>0 and beds!='' and beds>0" few_columns.csv > few_columns_cleansed.csv


   echo "Filtering by neighbourhood..."
   csvsql --query "select pf.neighbourhood_cleansed, pf.price, pf.square_feet from few_columns_cleansed pf where pf.neighbourhood_cleansed='$NEIGHBOURHOOD'" few_columns_cleansed.csv > final.csv

   echo "Transforming into a gnuplot friendly format..."
   sed 's/,/\t\t/g' final.csv > ${OUTPUT_FILE}.data && echo -n "#" | cat - ${OUTPUT_FILE}.data > temp.txt && mv temp.txt ${OUTPUT_FILE}.data


   echo "Exporting as JSON..."
   csvjson final.csv > ${OUTPUT_FILE}.json

   echo "Cleaning..."
   rm few_columns_cleansed.csv few_columns.csv final.csv

}

NEIGHBOURHOOD=$1

DATA_FOLDER=data
OUTPUT_FOLDER=data/treated-data

rm -rf $OUTPUT_FOLDER
mkdir -p $OUTPUT_FOLDER

echo "\n***Creating 2015 file\n"
create_year_file ${DATA_FOLDER}/paris-may-2015.csv $NEIGHBOURHOOD 41 40 23 33 38 35 ${OUTPUT_FOLDER}/2015_edit

echo "\n***Creating 2016 file\n"
create_year_file ${DATA_FOLDER}/paris-may-2016.csv $NEIGHBOURHOOD 58 57 37 49 54 51 ${OUTPUT_FOLDER}/2016_edit

echo "\n***Creating 2017 file\n"
create_year_file ${DATA_FOLDER}/paris-may-2017.csv $NEIGHBOURHOOD 61 60 40 52 57 54 ${OUTPUT_FOLDER}/2017_edit

echo "\n***Creating 2018 file\n"
create_year_file ${DATA_FOLDER}/paris-may-2018.csv $NEIGHBOURHOOD 61 60 40 52 57 54 ${OUTPUT_FOLDER}/2018_edit

PLANE=`python3 svd.py`

gnuplot -e "splot '${OUTPUT_FOLDER}/2015_edit.data' using 2:(2015):3 notitle, '${OUTPUT_FOLDER}/2016_edit.data' using 2:(2016):3 notitle, '${OUTPUT_FOLDER}/2017_edit.data' using 2:(2017):3 notitle,'${OUTPUT_FOLDER}/2018_edit.data' using 2:(2018):3 notitle; set xlabel 'Price'; set ylabel 'Year'; set zlabel 'Square Feet'; set view 56,335; set ytics (2015,2016,2017,2018); set size 2.0, 1.0; set terminal postscript portrait enhanced color dashed lw 1 \"Helvetica\" 14; set output \"${NEIGHBOURHOOD}.ps\"; replot; set terminal x11; set size 1,1;"


gnuplot -e "splot '${OUTPUT_FOLDER}/2015_edit.data' using 2:(2015):3 notitle, '${OUTPUT_FOLDER}/2016_edit.data' using 2:(2016):3 notitle, '${OUTPUT_FOLDER}/2017_edit.data' using 2:(2017):3 notitle,'${OUTPUT_FOLDER}/2018_edit.data' using 2:(2018):3 notitle, ${PLANE} notitle; set xlabel 'Price'; set ylabel 'Year'; set zlabel 'Square Feet'; set view 56,335; set ytics (2015,2016,2017,2018); set size 2.0, 1.0; set terminal postscript portrait enhanced color dashed lw 1 \"Helvetica\" 14; set output \"${NEIGHBOURHOOD}-plane-fitting.ps\"; replot; set terminal x11; set size 1,1;"

