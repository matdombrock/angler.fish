set -q ANG_DL_DICT; or set -gx ANG_DL_DICT "="

# Get all values, one per line
# NOTE: Fish expects lists to be returned as multiple lines
function dict.values
    set -l dict $argv[1..-1]
    for pair in $dict
        set -l v (string split "$ANG_DL_DICT" $pair)[2]
        echo $v
    end
end
