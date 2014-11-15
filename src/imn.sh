#!/bin/bash
BASE=source/aa5/munawir_arab_indo.djvu
BASE_DIR=source/aa5/imn.djvu
OUTPUT=img/imn/
#for i in {0..10}; do 
for i in {1594..1600}; do 
	div=$((i/100))	
	ddjvu -page=$i -format=tiff $BASE $BASE_DIR/$div/$i.tiff
  convert $BASE_DIR/$div/$i.tiff $BASE_DIR/$div/$i.jpg
	mkdir -p $OUTPUT/$div $BASE_DIR/$div
	#scantailor-cli -v --dpi=300 --output-dpi=300 --threshold=-20 \
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		$BASE_DIR/$div/$i.jpg $BASE_DIR/$div
	convert -verbose $BASE_DIR/$div/$i.tif -trim -resize 750 -colors 4 \
		$OUTPUT/$div/$i.png
done
