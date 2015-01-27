#!/bin/bash

for path in img/*; do
	book=$(basename $path)
	# Natural versioning ls sorting with -v
	if [ -f ${book}.csv ]; then
		echo "${book}.csv found, skipping csv generation"
	else
		for i in $(ls -v $path/*/*png); do 
			identify -format "%f,%w,%h,%[fx:w/h]" "$i"
			#identify -format "%d/%f,%w,%h,%[fx:w/h]" "$i"
		done | tee ${book}.csv
	fi
	./src/analyse-csv.pl ${book}.csv -1 | tee ${book}.report.txt
done

