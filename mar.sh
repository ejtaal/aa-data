#!/bin/bash
BASE=source/aa5/Marbawi/
OUTPUT=img/maw/
for i in {100..816}; do  #816
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	nice scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		$BASE/$(printf %04d $i).jpg $BASE/$div/
	nice convert -verbose $BASE/$div/$(printf %04d $i).tif -trim -resize 750 -colors 4 \
		"$OUTPUT/$div/maw-$(printf %04d $i).png"
done
