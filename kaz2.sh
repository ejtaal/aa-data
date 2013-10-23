#!/bin/bash
BASE=source/aa5/KAZ2/
OUTPUT=img/kaz/
#for i in {100..1866}; do 
for i in {0..1660}; do
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		$BASE/kaz2-$i.png $BASE/$div/
		#--content-detection=cautious --layout=1 \
	convert -verbose $BASE/$div/kaz2-$i.tif -trim -resize 750 -colors 4 \
		"$OUTPUT/$div/kaz2-$(printf %04d $i).png"
done
