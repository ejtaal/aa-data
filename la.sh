#!/bin/bash
BASE=source/aa5/la.pdf/
OUTPUT=img/la/
for i in {00..49}; do 
	mkdir -p $OUTPUT/$i
	for j in $BASE/$i/*pbm; do 
		scantailor-cli -v --dpi=300 --output-dpi=300 --threshold=-20 \
			$j $BASE/$i/
		convert -verbose $BASE/$i/$(basename $j .pbm).tif -trim -resize 1200 -colors 4 \
			$OUTPUT/$i/$(basename $j .pbm).png
	done
done
