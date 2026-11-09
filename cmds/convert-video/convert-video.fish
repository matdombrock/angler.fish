#!/usr/bin/env fish

set input $argv[1]
set output $argv[2]
set cfr $argv[3]
if test -z "$cfr"
    set cfr 28
end

mkdir -p ~/Videos/convert

# Get video height
set height (ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$input")
set even_height (math $height - $height % 2)

ffmpeg -i "$input" -vf "crop=iw:$even_height" -c:v libx265 -crf $cfr -c:a aac ~/Videos/convert/"$output"

echo "Converted and saved to ~/Videos/convert"
