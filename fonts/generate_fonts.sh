#!/usr/bin/env tcsh

set OUTPUT_DIR = "../users/halcyon_modules/splitkb/hlc_tft_display/graphics/fonts"

echo "Generating FiraCode-20 font..."
qmk painter-make-font-image -f FiraCode-Medium.ttf --size 20 -o FiraCode-20.png
qmk painter-convert-font-image -i FiraCode-20.png -f mono2

echo "Moving FiraCode-20 files to $OUTPUT_DIR..."
mv FiraCode-20.qff.c $OUTPUT_DIR/FiraCode-20.qff.c
mv FiraCode-20.qff.h $OUTPUT_DIR/FiraCode-20.qff.h

echo "Cleaning up temporary files..."
rm FiraCode-20.png

echo ""
echo "Font generation complete!"
echo "Files have been moved to $OUTPUT_DIR"
