#!/bin/bash
PREFIX=auh
BASE=source/aa6/$PREFIX
OUTPUT=img/$PREFIX
#for i in {200..201}; do
for i in {0..1897}; do
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	#convert $BASE/uqq-${i}.jpg -chop  0x50 $BASE/uqq-${i}-chop.jpg
		#--despeckle=aggressive \
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		--color-mode=black_and_white \
		--threshold=-50 \
		--despeckle=aggressive \
		"$BASE/$PREFIX-$(printf %04d $i).jpg" $BASE/$div/
		#--color-mode=color_grayscale \
		#--despeckle=aggressive \
	convert -verbose "$BASE/$div/$PREFIX-$(printf %04d $i).tif" \
		-fuzz 5% -trim \
		-depth 2 \
		-colors 4 \
		-adaptive-resize 1000 \
		-strip +profile '*' \
		"$OUTPUT/$div/$PREFIX-$(printf %04d $i).png"
		#-adaptive-resize 1000 \
		#-level 0%,100%,0.5 \
		#-sharpen 4 \
done
