# Get a char with no blocking
function input.nb
    set -l oldmode (stty -g)
    stty -icanon -echo min 0 time 0
    set char (dd bs=1 count=1 2>/dev/null)
    # Clear the buffer by reading until nothing is left
    while true
        set discard (dd bs=1 count=1 2>/dev/null)
        if test -z "$discard"
            break
        end
    end
    stty $oldmode
    echo $char
end
