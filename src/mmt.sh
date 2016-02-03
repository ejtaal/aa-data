#!/bin/bash
PREFIX=mmt
BASE=$HOME/github/aa-data/source/6.2/$PREFIX
OUTPUT=$HOME/github/aa-data/img/$PREFIX
# Special 2 page layout counter:
j=1
#for i in {49..503}; do
for i in {50..503}; do
	if [ "$j" = 0 ]; then
		j=$((i*2+1))
	fi
	div=$((i/100))	
	divj=$((j/100))	
	mkdir -p $OUTPUT/$divj $BASE/$div
	#for j in $BASE/$i/*pbm; do
	#convert -verbose -density 300 "${PDF}[$i]" $BASE/$div/$i.png
	#convert $BASE/uqq-${i}.jpg -chop  0x50 $BASE/uqq-${i}-chop.jpg
		#--despeckle=aggressive \
	$HOME/temp/scantailor-enhanced/scantailor-cli -v --dpi=600 --output-dpi=1200 \
		--layout=2 \
		--color-mode=color_grayscale \
		--disable-content-detection --enable-page-detection \
		--enable-fine-tuning \
		--margins=0.1 \
		--white-margins=true \
		--normalize-illumination \
		"$BASE/$PREFIX-$(printf %03d $i).jpg" $BASE/
		#--dewarping=auto \
		#--content-detection=cautious \
		#--despeckle=aggressive \
		#--enable-auto-margins \
		#--white-margins=true \
		#--disable-content-detection --enable-page-detection \
		#--enable-auto-margins \
		#--enable-fine-tuning \
		#--dewarping=auto \
		#--enable-page-detection \
		#--content-detection=cautious \
		#--orientation=left \

## 	scantailor-cli -v --dpi=600 --output-dpi=1200 \
## 		--layout=2 \
## 		--color-mode=color_grayscale \
## 		--margins=0.1 \
## 		--normalize-illumination \
## 		"$BASE/$PREFIX-$(printf %03d $i).jpg" $BASE/

		#--normalize-illumination \
		#--white-margins=true \
		#--threshold=-15 \
		#--content-detection=cautious \
		#--white-margins=true \
		#--threshold=5 \
		#"$BASE/$PREFIX-$(printf %04d $i).jpg" $BASE/$div/
		#--color-mode=color_grayscale \
		#--color-mode=black_and_white \
		#--despeckle=aggressive \
		#--despeckle=aggressive \
		#--threshold=-50 \
	#convert -verbose "$BASE/$div/$PREFIX-$(printf %04d $i).tif" \
	#for page in "1"; do
	for page in 2R 1L; do
		div=$((j/100))
		img="$BASE/$PREFIX-$(printf %03d $i)_${page}.tif"
		imgjpg="$BASE/$PREFIX-$(printf %03d $i)_${page}.jpg"
		convert -verbose "$img" -quality 95 "$imgjpg" \
			&& mv -vf "$img" "${img}.org"
	
		scantailor-cli -v --dpi=300 --output-dpi=300 \
			--layout=1 \
			--color-mode=color_grayscale \
			"$imgjpg" $BASE/
			#--color-mode=black_and_white \

		convert -verbose "$img" \
			-white-threshold 80% \
			-black-threshold 20% \
			-colorspace Gray \
			-fuzz 5% \
			-trim \
			-strip +profile '*' \
			+repage \
			-adaptive-resize '1000>' \
			-colors 4 \
			"$OUTPUT/$divj/$PREFIX-$(printf %04d $j).png"
		j=$((j+1))
	done

			#-sharpen 3 \
			#-white-threshold 90% \
			#-sharpen 5 \
#	convert -verbose "$BASE/$PREFIX-$(printf %03d $i).tif" \
			#-colors 256
#		-trim \
#		-strip +profile '*' \
#		+repage \
#		-adaptive-resize 1000 \
#		-colorspace Gray \
#		-colors 4 \
#		"$OUTPUT/$div/$PREFIX-$(printf %04d $j).png"

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
