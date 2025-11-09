set run true

set bw 48
set bh 9
set buffer_size (math $bw x $bh)

set buf ""

set empty "\
........
........
........
........
........
"

set zero "\
.000000.
.0....0.
.0....0.
.0....0.
.000000.
"

set one "\
...00...
....0...
....0...
....0...
...000..
"

set two "\
.000000.
......0.
.000000.
.0......
.000000.
"

set three "\
.000000.
......0.
.000000.
......0.
.000000.
"

set four "\
.0....0.
.0....0.
.000000.
......0.
......0.
"
set five "\
.000000.
.0......
.000000.
......0.
.000000.
"

set six "\
.000000.
.0......
.000000.
.0....0.
.000000.
"

set seven "\
.000000.
......0.
.....0..
....0....
...0....
"

set eight "\
.000000.
.0....0.
.000000.
.0....0.
.000000.
"

set nine "\
.000000.
.0....0.
.000000.
......0.
.000000.
"

set colon "\
........
...00...
........
...00...
........
"

set digits $zero $one $two $three $four $five $six $seven $eight $nine $colon $empty

set date_arr (date +"%H %M %S" | string split ' ' | string split '')

for d in $date_arr
    echo -n $digits[(math $d + 1)]
end
echo ""
exit

set template "\
000000000000000000000000000000000000000000000000
0..............................................0
0..............................................0
0..............................................0
0..............................................0
0..............................................0
0..............................................0
0..............................................0
000000000000000000000000000000000000000000000000
"

for i in (seq 1 $buffer_size)
    set buf[$i] "."
end

clear
while $run != true
    # Move cursor to top-left
    printf "\033[H"
    # Hide cursor
    printf "\033[?25l"
    # Update
    for i in (seq 1 $buffer_size)
        set buf[$i] "."
        # if test (math "$(random) % 10") -gt 5
        #     set buf[$i] "#"
        # end
    end
    # Draw
    for i in (seq 1 $buffer_size)
        echo -n $buf[$i]
        if test (math "$i % $bw") -eq 0
            echo ""
        end
    end

    sleep (math 1 / 12)
    # Show cursor
    printf "\033[?25h"
end
