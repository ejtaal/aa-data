#!/bin/bash
BASE=source/aa5/KAZ2/
OUTPUT=img/kaz/
#for i in {100..1866}; do 
#for i in {0..1660}; do
# Kaz vol 2, p11 = KAZ p1403 ==>> vol2_page = page - 1392
# Odd ones out:
#for i in 1417; do
for i in 1417 1899 1979 2282 2315 2322 2354 2408 2412 2426 2428 2612; do
	original=$((i-1392))
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	convert $BASE/kaz2-$original.png \
		-bordercolor white -border 10x10 \
		$BASE/kaz2-$original-border.png
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		$BASE/kaz2-$original-border.png $BASE/$div/
		#--content-detection=cautious --layout=1 \
	convert -verbose $BASE/$div/kaz2-$original-border.tif \
		-trim -resize 750 -colors 4 \
		"$OUTPUT/$div/kaz-$(printf %04d $i).png"
done
		#--color-mode=color_grayscale \
