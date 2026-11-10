# Get a single char
# Returns on input
function input.char
    set -l msg $argv
    read --nchars=1 -P $msg(set_color brwhite) char
    if test $status -ne 0
        exit
    end
    echo $char
end
