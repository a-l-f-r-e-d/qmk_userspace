#!/usr/bin/env tcsh

set OUTPUT_DIR = "../users/halcyon_modules/splitkb/hlc_tft_display/graphics/numbers"

# Generate numbers 0-9
foreach i (0 1 2 3 4 5 6 7 8 9)
  echo "Generating $i.png..."
  magick -size 300x420 \
    -background black \
    -fill white \
    -font FiraCode-Medium.ttf \
    -pointsize 288 \
    -gravity center \
    label:"$i" \
    -resize 75x105 \
    -monochrome \
    -type Bilevel \
    $i.png

  echo "Converting $i.png to QGF..."
  qmk painter-convert-graphics -i $i.png -o . -f mono2

  echo "Moving $i.qgf.* to $OUTPUT_DIR..."
  mv $i.qgf.c $OUTPUT_DIR/$i.qgf.c
  mv $i.qgf.h $OUTPUT_DIR/$i.qgf.h

  echo "Completed $i"
  echo ""
end

# Generate undefined (question mark)
echo "Generating undef.png..."
magick -size 300x420 \
  -background black \
  -fill white \
  -font FiraCode-Medium.ttf \
  -pointsize 288 \
  -gravity center \
  label:"?" \
  -resize 75x105 \
  -monochrome \
  -type Bilevel \
  undef.png

echo "Converting undef.png to QGF..."
qmk painter-convert-graphics -i undef.png -o . -f mono2

echo "Moving undef.qgf.* to $OUTPUT_DIR..."
mv undef.qgf.c $OUTPUT_DIR/undef.qgf.c
mv undef.qgf.h $OUTPUT_DIR/undef.qgf.h

echo "Completed undef"
echo ""

echo "All number images generated and converted to QGF!"
echo "Files have been moved to $OUTPUT_DIR"
