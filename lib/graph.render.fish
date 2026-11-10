# A stateless graphics system

# Example frame
# set frame "\
# w w w w
# w w w w
# w r w w
# r g b y"

# Render frame with unicode half blocks
function graph.render
    set -l frame_str $argv[1]
    set -l mode $argv[2]
    if test -z "$mode"
        set mode half
    end
    function get_color
        set -l c $argv[1]
        switch $c
            case r
                echo red
            case g
                echo green
            case b
                echo blue
            case y
                echo yellow
            case c
                echo cyan
            case m
                echo magenta
            case w
                echo white
            case l
                echo black
            case .
                echo black
            case n
                echo normal
            case R
                echo brred
            case G
                echo brgreen
            case B
                echo brblue
            case Y
                echo bryellow
            case C
                echo brcyan
            case M
                echo brmagenta
            case W
                echo brwhite
            case L
                echo brblack
        end
    end

    set -l lines (string split \n $frame_str)
    set -l height (count $lines)
    set -l width (string length $lines[1])

    if test "$mode" = full
        # Full block rendering: each cell is two '█'
        for i in (seq 1 $height)
            set -l row (string split '' $lines[$i])
            for j in (seq 1 $width)
                set -l fg $row[$j]
                if test "$fg" = ' '
                    continue
                end
                set_color (get_color $fg)
                echo -n '██'
                set_color normal
            end
            echo ''
        end
    else
        # If odd number of lines, pad with white line
        if test (math "$height % 2") -eq 1
            set lines $lines white_line
        end

        for i in (seq 1 2 $height)
            set -l top (string split '' $lines[$i])
            set -l bottom (string split '' $lines[(math "$i + 1")])
            for j in (seq 1 $width)
                set -l fg $top[$j]
                set -l bg $bottom[$j]

                if test "$fg" = ' '; or test "$bg" = ' '
                    continue
                end

                set_color (get_color $fg)
                set_color -b (get_color $bg)

                echo -n '▀'
                set_color normal
            end
            echo ''
        end
    end
end
