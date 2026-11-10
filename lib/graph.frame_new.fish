function graph.frame_new
    set -l w $argv[1]
    set -l h $argv[2]
    set -l c $argv[3]
    set -l frame
    for y in (seq 1 $h)
        for x in (seq 1 $w)
            set -a frame $c
        end
        set -a frame "\n"
    end
    echo -e (string join '' $frame) | string collect
end
