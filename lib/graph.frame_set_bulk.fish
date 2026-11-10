# Set bulk pixels in the frame
function graph.frame_set_bulk
    set -l frame $argv[1]
    set -l points $argv[2..-1]

    set -l lines (string split \n $frame)

    for point in $points
        # Split the point string into x, y, c
        set -l parts (string split ' ' $point)
        set -l x $parts[1]
        set -l y $parts[2]
        if test $y -gt (count $lines)
            continue
        end
        if test $y -lt 1
            continue
        end
        if test $x -gt (string length $lines[$y])
            continue
        end
        if test $x -lt 1; or test $y -lt 1
            continue
        end
        set -l c $parts[3]

        # Get the line and split into characters
        set -l line $lines[$y]
        set -l chars (string split '' $line)

        # Replace character at position x (Fish arrays are 1-based)
        set chars[$x] $c

        # Reconstruct the line
        set lines[$y] (string join '' $chars)
    end

    # Output the new frame
    printf '%s\n' $lines | string collect
end
# Example usage:
# set frame (graph.frame_new 10 5 .)
# set frame (graph.frame_set_bulk $frame "1 1 r" "2 2 g" "3 3 b")
# graph.render $frame
