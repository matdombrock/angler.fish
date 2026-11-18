#!/usr/bin/env fish
# This is super hacky
set ANG ~/.config/fish/functions/:ang

set target (string split " " $argv[1])[1]

set docs (cat "$ANG/docs.md")
set docl
for line in $docs
    if string match -q "$target|*" "$line"
        set docl $line
    end
end
if test -z "$docl"
    echo $target not found!
end
for line in (string split "|" $docl)
    if string match -q ":\$*" "$line"
        set line (string replace -a ":" "\n" $line)
    end
    echo -e $line
end
