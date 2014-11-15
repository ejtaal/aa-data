#!/bin/bash
BASE=source/aa5/KAZ1/
OUTPUT=img/kaz/
#for i in {100..1866}; do 
#for i in {0..1410}; do  #1410
# Odd ones out
for i in 177 183 185 249 269 1117 1272; do  #1410
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	convert $BASE/kaz1-$i.png \
		-bordercolor white -border 10x10 \
		$BASE/kaz1-$i-border.png
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		$BASE/kaz1-$i-border.png $BASE/$div/
	convert -verbose $BASE/$div/kaz1-$i-border.tif -trim -resize 750 -colors 4 \
		"$OUTPUT/$div/kaz-$(printf %04d $i).png"
done
