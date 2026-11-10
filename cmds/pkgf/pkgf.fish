#!/usr/bin/env fish
set ANG ~/.config/fish/functions/:ang
source $ANG/lib/core.fish
source $ANG/lib/input.fish

function yayf
    set yayq yay -Ss $query --singlelineresults
    set fzfflags --height 80% --preview 'yay -Si {1}' --preview-window 'down:50%,wrap'
    set sel ($yayq | fzf $fzfflags)
    set pkg (string split " " $sel)[1]
    echo (sc g)Selected:
    echo (sc n)$sel
    set accept (input.char (sc y)"install? (Y/n)")
    if test "$accept" = n
        echo (sc r)Declined!
        exit 0
    end
    yay -S $pkg
end

set query $argv[1]
yayf $query
