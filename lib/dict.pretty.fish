set -q ANG_DL_DICT; or set -gx ANG_DL_DICT "="

# Pretty print the dictionary
function dict.pretty
    set -l dict $argv[1..-1]
    for pair in $dict
        set -l k (string split "$ANG_DL_DICT" $pair)[1]
        set -l v (string split "$ANG_DL_DICT" $pair)[2]
        set_color --bold green
        echo -n "$k"
        set_color cyan
        echo -n ": "
        set_color yellow
        echo "$v"
        set_color normal
    end
end
