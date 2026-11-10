set -q ANG_DL_DICT; or set -gx ANG_DL_DICT "="

# Expand a dictionary string into a list
# For example "alice=alice smol bart=bart simpson charlie=charlie brown" becomes: 
# alice=alice smol
# bart=bart simpson
# charlie=charlie brown
# NOTE: Fish expects lists to be returned as multiple lines
function dict.expand
    set -l words (string split ' ' $argv)
    set -l pair ""
    for word in $words
        if string match -qr "$ANG_DL_DICT" -- $word
            if test -n "$pair"
                echo $pair
            end
            set pair $word
        else
            set pair "$pair $word"
        end
    end
    if test -n "$pair"
        echo $pair
    end
end
