#!/bin/bash
PDF=source/aa5/LughatUlQuranByGAParwez.pdf
BASE=source/aa5/ULQ/
OUTPUT=img/ulq/
#for i in {100..1866}; do 
for i in {0..1856}; do  #1856
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/ulq-$i.png
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		$BASE/ULQ_$i.png $BASE/$div/
	convert -verbose $BASE/$div/ULQ_$i.tif -trim -resize 750 -colors 4 \
		"$OUTPUT/$div/ulq-$(printf %04d $i).png"
done
