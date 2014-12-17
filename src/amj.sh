#!/bin/bash
PREFIX=amj
BASE=source/aa6/$PREFIX
OUTPUT=img/$PREFIX
#for i in {200..201}; do
# Odd ones out
#for i in 14 63 155 216 218 225 226 232 241 252 256 260 268 275 285 287 296 298 309 336 345 347 351 360 406 427 429 431 434 456 466 484 514 524 528 537 555 557 589 591 625 639 678 790 792 802 808 810 812 816 968; do
for i in {1..1017}; do
	div=$((i/100))	
	mkdir -p $OUTPUT/$div $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	#convert $BASE/uqq-${i}.jpg -chop  0x50 $BASE/uqq-${i}-chop.jpg
		#--despeckle=aggressive \
	scantailor-cli -v --dpi=300 --output-dpi=300 \
		--layout=1 \
		--color-mode=color_grayscale \
		--threshold=-30 \
		--content-detection=normal \
		--normalize-illumination \
		--white-margins=true \
		"$BASE/$PREFIX-$(printf %04d $i).jpg" $BASE/$div/
		#--color-mode=color_grayscale \
		#--despeckle=aggressive \
	convert -verbose "$BASE/$div/$PREFIX-$(printf %04d $i).tif" \
		-level 40%,80% \
		-fuzz 5% -trim \
		-adaptive-resize 1250 \
		-colors 4 \
		-strip +profile '*' \
		"$OUTPUT/$div/$PREFIX-$(printf %04d $i).png"
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
