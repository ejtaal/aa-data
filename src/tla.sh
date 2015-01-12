#!/bin/bash
PREFIX=tla
BASE=source/aa6/$PREFIX
OUTPUT=img/$PREFIX
#for i in {200..201}; do
# Odd ones out
#for i in {41..44}; do
for i in {1..104}; do
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	#convert $BASE/uqq-${i}.jpg -chop  0x50 $BASE/uqq-${i}-chop.jpg
		#--despeckle=aggressive \
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		--color-mode=color_grayscale \
		--content-detection=normal \
		--normalize-illumination \
		--white-margins=true \
		"$BASE/$PREFIX-$(printf %04d $i).jpg" $BASE/$div/
		#--threshold=-30 \
		#--color-mode=color_grayscale \
		#--despeckle=aggressive \
	convert -verbose "$BASE/$div/$PREFIX-$(printf %04d $i).tif" \
		-fuzz 5% -trim \
		-adaptive-resize 1000 \
		-colors 4 \
		-strip +profile '*' \
		"$OUTPUT/$div/$PREFIX-$(printf %04d $i).png"
		#-level 40%,80% \
		#-adaptive-resize 1250 \
		#-level 0%,85% \
		#-shave 10x10 \
		#-contrast -contrast \

		#-colors 8 \
		#-depth 3 \
		#-colors 8 \
		#-adaptive-resize 1000 \
		#-level 0%,100%,0.5 \
		#-sharpen 4 \
done
