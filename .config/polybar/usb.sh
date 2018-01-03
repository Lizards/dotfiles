#!/bin/sh

# https://github.com/jaagr/polybar/wiki/User-contributed-modules#usb

# The USB symbol from ttf-font-awesome
sym=""
# The default directory
dir="/mnt"

if [ $# -ne 0 ]; then
  dir="${1%/}"
fi

for f in `ls $dir`; do
  # Outputs the size of the filesystem. 'avail' outputs available space,
  # it can be changed for 'size', 'used'... See man df for more information.
  size=`df --output=avail -h $dir/$f | tail -1`
  size="${size:1}B"
  res="$res$sym $f ($size)  "
done

echo "${res%*  }"