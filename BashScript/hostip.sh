#!/bin/bash

#check if a search has been specified
numargs=$#
if [ $numargs -lt 1 ]
then
     echo #new line separator
     echo "Search string not specified"
     exit
fi

#generate the log file 
sstring=$1 #search string
count=0
LIMIT=10

while [ "$count" -lt "$LIMIT" ]
do
    datestr=`date +%m-%d-%Y_%N` 

   
   touch "tempvar.txt"
   touch "temp2.txt"
   #this will make the file in format of eg [log_MM-DD-YYYY_Nanoseconds.txt] 
   touch "log_$datestr.txt"
   
   grep -m `expr $count + 1` $sstring words.txt | tail -1 >> tempvar.txt

   host www."$( cat tempvar.txt )".com >> temp2.txt

   cat tempvar.txt >> log_$datestr.txt


Found="$( grep -o "found" temp2.txt )"
YES="found"
if [ "$Found" ==  "$YES" ]
then
    echo "NO Such Web Found"  >> log_$datestr.txt
else
   head -n 1 temp2.txt|tail -c 18 >> log_$datestr.txt 
fi
 
sleep 2 #wait for 2 seconds also putting time in 0.2 seconds will increase by the power of 10.
count=`expr $count + 1`
   rm tempvar.txt
   rm temp2.txt
done #while
echo
exit 0
