#!/bin/bash
#
# Taken from http://blog.yjl.im/2014/12/wavebash.html
#

WIDTH=$(tput cols)

w='.)`-,.'
printf -v sep '%*s' $((WIDTH - ${#w}))
w="$w${sep// /_}"

while sleep .05; do
  echo "${w:x}${w:0:x}"
  ((x = (x + 1) % ${#w}))
done