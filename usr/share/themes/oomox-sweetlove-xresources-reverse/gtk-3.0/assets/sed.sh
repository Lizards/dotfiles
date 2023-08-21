#!/bin/sh
sed -i \
         -e 's/#1c1c1c/rgb(0%,0%,0%)/g' \
         -e 's/#dfcd9f/rgb(100%,100%,100%)/g' \
    -e 's/#382e2e/rgb(50%,0%,0%)/g' \
     -e 's/#3D8F8F/rgb(0%,50%,0%)/g' \
     -e 's/#1c1c1c/rgb(50%,0%,50%)/g' \
     -e 's/#e4decd/rgb(0%,0%,50%)/g' \
	"$@"
