# Send to the cli prompt
function cl
    set cmd "$argv[1]"
    commandline -r -- "$cmd"
    commandline -f repaint
end
