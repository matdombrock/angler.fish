# Color helper
function sc
    set c normal
    switch $argv[1]
        case r
            set c brred
        case g
            set c brgreen
        case b
            set c brblue
        case y
            set c bryellow
        case c
            set c brcyan
        case m
            set c brmagenta
        case n
            set c normal
    end
    set_color $c
end

# Send to the cli prompt
function cl
    set cmd "$argv[1]"
    commandline -r -- "$cmd"
    commandline -f repaint
end

# Handle params
# Interactively if needed
function param
    set -l q $argv[1]
    set -l v $argv[2]
    if test -z "$v"
        read -P "$(sc y)\$$q: " v
    end
    echo $v
end

# Ensure an application is installed and in $PATH
function ensure
    set cmd $argv[1]
    if test -z "$(which "$cmd" 2>/dev/null)"
        echo (sc r)"! ERROR:"
        echo (sc y)\'$cmd\' not found!
        echo If you think this program is actually installed, ensure its in \$PATH, and matches the exact name \'$cmd\'
        echo If the program is installed under another name, make an alias for $cmd
        echo (sc w)"-------"
        echo (sc r)unable to continue
        echo (sc n)
        return 1
    end
    return 0
end
