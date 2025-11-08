function graphics.color_matrix
    set -l sc $argv[1]
    set -l half $argv[2]
    set -l lines (string split \n $sc)
    for line in $lines
        # echo $line
        set -l chars (string split ' ' $line)
        for c in $chars
            switch $c
                case r
                    set_color red
                case R
                    set_color brred
                case g
                    set_color green
                case G
                    set_color brgreen
                case b
                    set_color blue
                case B
                    set_color brblue
                case y
                    set_color yellow
                case Y
                    set_color bryellow
                case c
                    set_color cyan
                case C
                    set_color brcyan
                case m
                    set_color magenta
                case M
                    set_color brmagenta
                case w
                    set_color white
                case W
                    set_color brwhite
                case '*'
                    set_color normal
            end
            if test $half = 1
                echo -n '█'
            else
                echo -n '██'
            end
        end
        echo ''
    end
end

set sc "\
r r r y y y
g W g c W c
b W b m W m
r r r y y y
g W W W W c
b b b m m m"

graphics.color_matrix $sc 0
