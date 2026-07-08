#!/usr/bin/env fish

# png2video.fish - Convert a directory of PNGs to an MP4 video
#
# Usage: ./pngs_to_video.fish [options] [directory]
#
# Options:
#   -o, --output FILE     Output video file (default: output.mp4)
#   -f, --fps FPS         Frames per second (default: 24)
#   -s, --sort ORDER      Sort order: name, numeric, time (default: name)
#   -r, --reverse         Reverse sort order
#   -h, --help            Show this help

set -l output_file "output.mp4"
set -l fps 24
set -l sort_order "name"
set -l reverse_flag ""

function show_help
    echo "Usage: "(status basename)" [options] [directory]"
    echo ""
    echo "Convert a directory of PNGs to an MP4 video."
    echo ""
    echo "Options:"
    echo "  -o, --output FILE     Output video file (default: output.mp4)"
    echo "  -f, --fps FPS         Frames per second (default: 24)"
    echo "  -s, --sort ORDER      Sort order: name, numeric, time (default: name)"
    echo "  -r, --reverse         Reverse sort order"
    echo "  -h, --help            Show this help"
    echo ""
    echo "Examples:"
    echo "  "(status basename)" ./frames"
    echo "  "(status basename)" -o animation.mp4 -f 30 -s numeric ~/renders"
end

# Parse arguments
set -l args (getopt -o o:f:s:rh --long output:,fps:,sort:,reverse,help -n (status basename) -- $argv 2>/dev/null)
if test $status -ne 0
    show_help
    exit 1
end

eval set -l parsed_args $args

set -l target_dir "."
set -l i 1

while test $i -le (count $parsed_args)
    switch $parsed_args[$i]
        case -o --output
            set i (math $i + 1)
            set output_file $parsed_args[$i]
        case -f --fps
            set i (math $i + 1)
            set fps $parsed_args[$i]
        case -s --sort
            set i (math $i + 1)
            set sort_order $parsed_args[$i]
        case -r --reverse
            set reverse_flag "--reverse"
        case -h --help
            show_help
            exit 0
        case --
            # no-op
        case '*'
            set target_dir $parsed_args[$i]
    end
    set i (math $i + 1)
end

# Check that the target exists and is a directory
if not test -d "$target_dir"
    echo "Error: '$target_dir' is not a directory." >&2
    exit 1
end

# Gather PNG files
set -l png_files

switch $sort_order
    case numeric
        set png_files (find "$target_dir" -maxdepth 1 -name '*.png' -print0 | sort -z -V | string split0)
    case time
        if find "$target_dir" -maxdepth 1 -name '*.png' -printf '' 2>/dev/null
            set png_files (find "$target_dir" -maxdepth 1 -name '*.png' -printf '%T@ %p\0' | sort -z -n | sed -z 's/^[0-9.]* //' | string split0)
        else
            set png_files (find "$target_dir" -maxdepth 1 -name '*.png' -exec ls -1t {} + | sort -t)
        end
    case '*'
        set png_files (find "$target_dir" -maxdepth 1 -name '*.png' -print0 | sort -z | string split0)
end

if test -n "$reverse_flag"
    set png_files $png_files[-1..1]
end

# Verify files exist
if test (count $png_files) -eq 0
    echo "Error: No PNG files found in '$target_dir'." >&2
    exit 1
end

echo "Found "(count $png_files)" PNG files."

# Detect alpha channel from the first PNG
set -l has_alpha false
set -l pix_fmt (ffprobe -v error -select_streams v:0 -show_entries stream=pix_fmt -of default=noprint_wrappers=1 $png_files[1] 2>/dev/null)
if string match -qr 'a' -- $pix_fmt
    set has_alpha true
    echo "Alpha channel detected, using VP9 codec with transparency."
    echo "Note: Use a .webm output file (e.g. -o out.webm) to preserve the alpha channel."
end

echo "Generating '$output_file' at $fps fps..."

# Build a temporary file list for ffmpeg
set -l tmp_list (mktemp -t pngs_XXXXXX.txt)

# Create absolute paths and write the file list
for f in $png_files
    echo "file '$f'" >> $tmp_list
end

# Run ffmpeg
if "$has_alpha"
    ffmpeg -y -r $fps -f concat -safe 0 -i "$tmp_list" \
        -c:v libvpx-vp9 -pix_fmt yuva420p -crf 18 -deadline good \
        "$output_file"
else
    ffmpeg -y -r $fps -f concat -safe 0 -i "$tmp_list" \
        -c:v libx264 -pix_fmt yuv420p -preset medium -crf 18 \
        "$output_file"
end

set -l ffmpeg_status $status

# Clean up
rm -f "$tmp_list"

if test $ffmpeg_status -eq 0
    echo "Done! Video saved to '$output_file'."
else
    echo "Error: ffmpeg failed." >&2
    exit 1
end
