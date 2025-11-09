set bw 48
set bh 9
set buffer_size (math $bw x $bh)

set buf ""

set sprite "\
.000000.
.0....0.
.000000.
.0....0.
.000000.
"

function init
    for i in (seq 1 $buffer_size)
        set buf[$i] "."
    end
end

function set_pixel
    set x $argv[1]
    set y $argv[2]
    set c $argv[3]
    set index (math $y x $bw + $x + 1)
    set buf[$index] $c
end

function draw_sprite
    set pos_x $argv[1]
    set pos_y $argv[2]
    set sprite_data $argv[3]
    set sprite_lines (string split "\n" $sprite_data)
    set sprite_h (count $sprite_lines)
    for y in (seq 1 $sprite_h)
        set line $sprite_lines[$y] | string replace -r "\n" "" | string trim
        set line_split (string split "" $line)
        set sprite_w (count $line_split)
        for x in (seq 1 $sprite_w)
            set c $line_split[$x]
            set_pixel (math $pos_x + $x) (math $pos_y + $y) $c
        end
    end
end

function draw
    set i 0
    for b in $buf
        set i (math $i + 1)
        echo -n $b
        if test (math $i % $bw) -eq 0
            echo ""
        end
    end
end

init

for i in (seq 0 $bw )
    set step (math 6.28 / 20)
    set pos (math $i x $step)
    set sin (math sin $pos)
    set h (math 4 + (math $sin x 4))
    set h (math round $h)
    # echo $h
    set_pixel $i $h "#"
end

draw
