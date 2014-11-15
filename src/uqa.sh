#!/bin/bash
BASE=source/aa5/uqa.pdf
#BASE_DIR=source/aa5/imn.djvu
OUTPUT=img/uqa/
#for i in {000..503}; do 
for i in {0..503}; do 
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#scantailor-cli -v --dpi=300 --output-dpi=300 --threshold=-20 \
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		$BASE/uqa-$i.jpg $BASE/$div
	convert -verbose $BASE/$div/uqa-$i.tif -trim -resize 750 -colors 4 \
		$OUTPUT/$div/$i.png
done
