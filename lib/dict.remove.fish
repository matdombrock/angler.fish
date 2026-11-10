set -q ANG_DL_DICT; or set -gx ANG_DL_DICT "="

# Remove a key
function dict.remove
    set -l key $argv[1]
    set -l dict $argv[2..-1]
    set -l new_dict
    for pair in $dict
        set -l k (string split "$ANG_DL_DICT" $pair)[1]
        set -l v (string split "$ANG_DL_DICT" $pair)[2]
        if test $k != $key
            set new_dict $new_dict "$k$ANG_DL_DICT$v"
        end
    end
    for item in $new_dict
        echo $item
    end
end
