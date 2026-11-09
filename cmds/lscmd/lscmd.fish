#!/usr/bin/env fish
# List registered commands

source $ANG/lib/core.fish
set ANG ~/.config/fish/functions/:ang

set fzfopt --with-shell "fish -c" --preview "'"$ANG/lscmd/fzfpre.fish"' {}" --preview-window=right,60%

set sel (cat "$ANG/docs.md" | fzf $fzfopt)
set cmd (string split "|" $sel)[1]
if test -z "$cmd"
    echo (sc r)invalid cmd!
    return
end
echo (sc g)$cmd
# Send ANG_ECHO to print instead of eval
# Build the expression
set exp (eval "set -x ANG_ECHO 1; $cmd")
echo (sc g)λ $exp
function action
    set -l spl (string split '' $argv[1])
    echo (sc n)$spl[1](sc y)(string join '' $spl[2..])
end
read -P "$(action eval)|$(action cli): " ch
if string match -q "e*" "$ch"
    # eval "$exp"
    eval $exp
else if string match -q "c*" "$ch"
    echo (sc g)sent to cli
    cl "$exp"
else
    echo (sc r)aborted!
end
