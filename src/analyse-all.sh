#!/bin/bash

for path in img/*; do
	book=$(basename $path)
	for i in $path/*/*png; do 
		identify -format "%d/%f,%w,%h,%[fx:w/h]" "$i"
	done | tee ${book}.csv
	./src/analyse-csv.pl ${book}.csv -1 | tee ${book}.report.txt
done

