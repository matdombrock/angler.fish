#!/usr/bin/env fish
# List registered commands

set ANG ~/.config/fish/functions/:ang
source $ANG/lib/core.fish

set docs (cat "$ANG/docs.md")
set lst
for doc in $docs
    set split (string split "|" "$doc")
    set lst $lst "$split[1] $split[2]"
end

set fzfopt --with-shell "fish -c" --preview "'"$ANG/lscmd/fzfpre.fish"' {}" --preview-window=down,30%
set sel (echo -e (string join "\n" $lst) | fzf $fzfopt)
set cmd (string split "|" $sel)[1]
if test -z "$cmd"
    echo (sc r)invalid cmd!
    return
end
echo (sc g)$cmd
# Send ANG_ECHO to print instead of eval
# Build the expression
set exp (eval "set -x ANG_ECHO 1; $cmd")
echo ""
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
