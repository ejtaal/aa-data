#!/bin/bash
PREFIX=elq
BASE=$HOME/github/aa-data/source/6.2/$PREFIX
OUTPUT=$HOME/github/aa-data/img/$PREFIX
PDF="$HOME/github/aa-data/source/elq.pdf"
# Use 1 for pdfimages/convert output, as that starts with 0
ADJUST=1
#for i in {200..201}; do
for i in {0..1211}; do
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	#convert $BASE/uqq-${i}.jpg -chop  0x50 $BASE/uqq-${i}-chop.jpg
		#--despeckle=aggressive \
		#"$BASE/$PREFIX-$(printf %04d $i).jpg" $BASE/$div/
		#--color-mode=color_grayscale \
		#--despeckle=aggressive \
		#--despeckle=aggressive \
		#--threshold=-50 \
	#convert -verbose "$BASE/$div/$PREFIX-$(printf %04d $i).tif" \
	# No need for scantailor as it's a proper pdf innit
	j=$((i+ADJUST))
	div=$((j/100))	
#	convert -verbose "$BASE/$PREFIX-$(printf %03d $i).pbm" \
#		-colors 256
#		"$BASE/$PREFIX-$(printf %03d $i).png"
#	ls -l "$BASE/$PREFIX-$(printf %03d $i).png"
	convert -verbose \
		-density 300 \
		"$PDF[$i]" \
		-background white -alpha remove \
		-trim \
		+repage \
		-strip +profile '*' \
		-filter Quadratic \
		-resize 1250 \
		-sharpen 3 \
		-depth 3 \
		-colors 12 \
		"$OUTPUT/$div/$PREFIX-$(printf %04d $j).png"
		#-depth 3 \
		#-depth 3 \
		#-colors 4 \
		#-transparent-color white \
#		-fuzz 50% \
#		-strip +profile '*' \
#		+repage \
#		-adaptive-resize 1000 \
#		-colorspace Gray \


		#-threshold 20% \
		#-colors 4 \
		#-depth 1 \
		#-fuzz 2% -trim \
		#-sharpen 4 \
done
