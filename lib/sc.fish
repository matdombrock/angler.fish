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
