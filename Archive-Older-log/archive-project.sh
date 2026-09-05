#!/bin/bash
#===============================
#Date:$date$
#Version: v1.0
#===============================

#Variables

BASE="Give Path"
DAYS=10
DEPTH=1 #File will only search for that folder only will not check other folder
RUN=0

#Check if the directory is present or not

if [[ ! -d $BASE ]]
then
	echo "Directory does not exist: $BASE"
	exit 1
fi

#Create 'archive' folder is present or not
if [[ ! -d $BASE/archive ]] 
then 
	mkdir $BASE/archive
fi

#Find the list of file larger than 12mb

for i in `find $BASE -maxdepth $DEPTH -type f -size +12M`
do
	if [[ $RUN -eq 0 ]] 
	then
		echo "[$(date "+%Y-%m-%d %H:%M:%S")] archiving $i ==> $BASE/archive"
		gzip $i || exit 1
		mv "$i.gz" "$BASE/archive" || exit 1
	fi
done

