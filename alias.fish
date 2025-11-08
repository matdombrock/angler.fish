#! /usr/bin/env fish

# Set aliases for some programs in this repo

# Automatically determine the base dir
set base (dirname (realpath (status --current-filename)))

alias :adv="$base/games/adv.fish"
alias :seer="cd ($base/seer/seer.fish)"
alias :finder="$base/fishfinder/finder.fish"
alias :fishfish="$base/fishfish/fish.fish"

echo set aliased:
alias | grep ':'
echo (set_color yellow)Note: these aliases are prefixed with a colon \(:\) to avoid conflicts with existing commands.(set_color normal)
