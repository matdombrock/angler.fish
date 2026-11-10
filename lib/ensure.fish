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
