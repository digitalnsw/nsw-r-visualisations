#!/bin/bash

set -e

# brew install ttf2pt1 (also available from CTAN)

mkdir -p "inst/fonts/metrics" "inst/fonts/outlines"

for font in inst/fonts/Public_Sans/static/*.ttf; do
  ttf2pt1 -b "$font"
  mv "${font%.ttf}.afm" "inst/fonts/metrics/"
  mv "${font%.ttf}.pfb" "inst/fonts/outlines/"
done
