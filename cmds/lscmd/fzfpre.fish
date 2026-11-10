#!/usr/bin/env fish

# This is super hacky
for line in (string split "|" $argv[1])
    if string match -q ":\$*" "$line"
        set line (string replace -a ":" "\n" $line)
    end
    echo -e $line
end
