#!/bin/bash
PREFIX=cqm
BASE=$HOME/github/aa-data/source/6.2/$PREFIX
OUTPUT=$HOME/github/aa-data/img/$PREFIX
# Use 1 for pdfimages output, as that starts with 0
ADJUST=1
#for i in {200..202}; do
for i in {0..795}; do
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	#convert $BASE/uqq-${i}.jpg -chop  0x50 $BASE/uqq-${i}-chop.jpg
		#--despeckle=aggressive \
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		--color-mode=black_and_white \
		"$BASE/$PREFIX-$(printf %03d $i).jpg" $BASE/
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
	convert -verbose "$BASE/$PREFIX-$(printf %03d $i).tif" \
		-trim \
		-strip +profile '*' \
		+repage \
		-adaptive-resize 1000 \
		-colorspace Gray \
		-depth 2 \
		"$OUTPUT/$div/$PREFIX-$(printf %04d $j).png"
		#-colors 4 \
#		-colors 2 \
#		-fuzz 50% \
#		-strip +profile '*' \
#		+repage \
#		-adaptive-resize 1000 \
#		-colorspace Gray \
#		-depth 2 \


		#-threshold 20% \
		#-colors 4 \
		#-depth 1 \
		#-fuzz 2% -trim \
		#-sharpen 4 \
done
