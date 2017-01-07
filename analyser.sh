#!/bin/bash
experiment="Test3"

while IFS='' read -r -d '' filename; do 
    
    DIR=$(dirname ${filename})
    /home/dlokam/r_code/parsecsv.pl $DIR/datasheet.csv

done < <(find /home/dlokam/r_code/$experiment -type f -iname '*.csv' -print0)
