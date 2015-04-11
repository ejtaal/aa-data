#!/bin/bash
PREFIX=mis
BASE=source/aa6.1/$PREFIX
OUTPUT=img/$PREFIX
for i in {0..2416}; do
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	#convert $BASE/uqq-${i}.jpg -chop  0x50 $BASE/uqq-${i}-chop.jpg
		#--despeckle=aggressive \
###	scantailor-cli -v --dpi=300 --output-dpi=300 \
###		--layout=1 \
###		--color-mode=black_and_white \
		#"$BASE/$PREFIX-$(printf %04d $i).jpg" $BASE/$div/
		#--color-mode=color_grayscale \
		#--despeckle=aggressive \
		#--despeckle=aggressive \
		#--threshold=-50 \
	#convert -verbose "$BASE/$div/$PREFIX-$(printf %04d $i).tif" \
	# No need for scantailor as it's a proper pdf innit
	j=$i
	div=$((j/100))	
	convert -verbose "$BASE/$PREFIX-$(printf %03d $i).pbm" \
		-trim \
		-adaptive-resize 1000 \
		-colorspace Gray \
		-depth 2 \
		-strip +profile '*' \
		"$OUTPUT/$div/$PREFIX-$(printf %04d $j).png"
		#-threshold 20% \
		#-colors 4 \
		#-depth 1 \
		#-fuzz 2% -trim \
		#-sharpen 4 \
done
