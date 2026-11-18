function _:snips
    set here (path dirname (status filename))
    set lst (cat $here/snips.md | string collect)
    echo -e "$lst" | fzf
end
