set -q ANG_DL_DICT; or set -gx ANG_DL_DICT "="

# Get value by key
function dict.get
    set -l key $argv[1]
    set -l dict $argv[2..-1]
    for pair in $dict
        set -l k (string split "$ANG_DL_DICT" $pair)[1]
        set -l v (string split "$ANG_DL_DICT" $pair)[2]
        if test $k = $key
            echo $v
            return
        end
    end
    echo null
    return
end
