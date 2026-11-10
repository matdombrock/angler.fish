set -q ANG_DL_DICT; or set -gx ANG_DL_DICT "="

# Set value by key
function dict.set
    set -l key $argv[1]
    set -l value $argv[2]
    set -l dict $argv[3..-1]
    set -l new_dict
    set -l found 0
    for pair in $dict
        set -l k (string split "$ANG_DL_DICT" $pair)[1]
        set -l v (string split "$ANG_DL_DICT" $pair)[2]
        if test $k = $key
            set new_dict $new_dict "$key$ANG_DL_DICT$value"
            set found 1
        else
            set new_dict $new_dict "$k$ANG_DL_DICT$v"
        end
    end
    if test $found -eq 0
        set new_dict $new_dict "$key$ANG_DL_DICT$value"
    end
    for item in $new_dict
        echo -e $item
    end
end
