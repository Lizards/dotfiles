#!/bin/sh
sed -i \
         -e 's/#29283B/rgb(0%,0%,0%)/g' \
         -e 's/#ffe7bd/rgb(100%,100%,100%)/g' \
    -e 's/#0b0835/rgb(50%,0%,0%)/g' \
     -e 's/#dd593c/rgb(0%,50%,0%)/g' \
     -e 's/#29283B/rgb(50%,0%,50%)/g' \
     -e 's/#ffe7bd/rgb(0%,0%,50%)/g' \
	"$@"
