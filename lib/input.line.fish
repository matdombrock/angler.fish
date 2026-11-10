# Get a line
# Returns on enter
function input.line
    set -l msg $argv
    read -P $msg(set_color brwhite) choice
    if test $status -ne 0
        exit
    end
    echo $choice
end
