#!/bin/bash
BASE=source/aa5/uqq/
OUTPUT=img/uqq/
#for i in {100..1866}; do 
for i in {2..10}; do  #451
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	#convert $BASE/uqq-${i}.jpg -chop  0x50 $BASE/uqq-${i}-chop.jpg
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		--despeckle=aggressive \
		--color-mode=color_grayscale \
		$BASE/uqq-${i}-chop.jpg $BASE/$div/
	convert -verbose $BASE/$div/uqq-$i-chop.tif \
		-level 0%,100%,0.5 \
		-sharpen 4 \
		-colors 8 \
		-fuzz 5% -trim \
		"$OUTPUT/$div/uqq-$(printf %04d $i).png"
		#-adaptive-resize 1000 \
done
