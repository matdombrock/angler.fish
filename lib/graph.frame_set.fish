# NOTE:
# This approach works but can result in bad indicies
# Its also not significantly faster
# set -l chars $chars[1..(math "$x - 1")] $c $chars[(math "$x + 1")..-1]
# set -a new_frame (string join '' $chars)
#
# NOTE: Not signficantly faster
# function graph.frame_set
#     set -l x $argv[1]
#     set -l y $argv[2]
#     set -l c $argv[3]
#     set -l frame $argv[4]
#     set -l lines (string split \n $frame)
#     for i in (seq 1 (count $lines))
#         if test $i = $y
#             set -l line $lines[$i]
#             # replace character at position x with c using string replace
#             set -l prefix (string sub -s 1 -l (math "$x - 1") $line)
#             set -l suffix (string sub -s (math "$x + 1") $line)
#             set -l new_line "$prefix$c$suffix"
#             set -a new_frame $new_line"\n"
#         else
#             set -a new_frame $lines[$i]"\n"
#         end
#     end
#     echo -e (string join '' $new_frame) | string collect
# end
#
# TODO:
# Batch draw calls to improve performance
# set a "pixel" in the frame at (x, y) with color c
function graph.frame_set
    set -l x $argv[1]
    set -l y $argv[2]
    set -l c $argv[3]
    set -l frame $argv[4]
    set -l new_frame
    set -l lines (string split \n $frame)
    for i in (seq 1 (count $lines))
        if test $i = $y
            set -l line $lines[$i]
            set -l chars (string split '' $line)
            for j in (seq 1 (count $chars))
                if test $j = $x
                    set -a new_frame $c
                else
                    set -a new_frame $chars[$j]
                end
            end
            set -a new_frame "\n"
        else
            set -a new_frame $lines[$i]"\n"
        end
    end
    echo -e (string join '' $new_frame) | string collect
end
