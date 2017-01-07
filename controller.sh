#!/bin/bash
RCODE=~/r_code/VTM_Leishmaniasis.r
a="0"
b="0"
c="0"
i="0" 
while [ $a -lt 10 ]
do
let "b=0";
    while [ $b -lt 3 ] 
    do
    let "c=0";
        while [ $c -lt 2 ]
        do
        mkdir /home/dlokam/r_code/Test3/Regression-$i
        cd /home/dlokam/r_code/Test3/Regression-$i
        Rscript --vanilla $RCODE $a $b $c
        i=$[$i+1]
        c=$[$c+1]
        done
    b=$[$b+1]
    done
a=$[$a+1]
done
