#!/bin/bash

input=$1
output=$2
cfr=${3:-28}

mkdir -p ~/Videos/convert

# Get video height
height=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$input")
even_height=$((height - height % 2))

ffmpeg -i "$input" -vf "crop=iw:$even_height" -c:v libx265 -crf $cfr -c:a aac ~/Videos/convert/"$output"

echo "Converted and saved to ~/Videos/convert"
