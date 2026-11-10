set -q ANG_DL_DICT; or set -gx ANG_DL_DICT "="

# Get all keys, one per line
# NOTE: Fish expects lists to be returned as multiple lines
function dict.keys
    set -l dict $argv[1..-1]
    for pair in $dict
        set -l k (string split "$ANG_DL_DICT" $pair)[1]
        echo $k
    end
end
