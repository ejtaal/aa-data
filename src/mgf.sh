#!/bin/bash
BASE=source/aa4/mgf.orig/
OUTPUT=img/mgf/
#for i in {0..9}; do 
for i in 3; do 
	mkdir -p $OUTPUT/$i; 
	#for j in $BASE/$i/*jpg; do 
	for j in $BASE/$i/*361*jpg; do 
		convert -verbose $j -resize 1000 -level 25%,75% \
			-trim -colors 8 $OUTPUT/$i/$(basename $j .jpg);
	done; 
done
