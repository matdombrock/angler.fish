function input.line
    set -l msg $argv
    read -P $msg(set_color brwhite) choice
    if test $status -ne 0
        exit
    end
    echo $choice
end

function input.char
    set -l msg $argv
    read --nchars=1 -P $msg(set_color brwhite) char
    if test $status -ne 0
        exit
    end
    echo $char
end

function input.nb
    stty -icanon -echo min 0 time 1
    set char (dd bs=1 count=1 2>/dev/null)
    stty sane
    echo $char
end
