# Handle params
# Interactively if needed
function param
    set -l pname $argv[1]
    set -l desc $argv[2]
    set -l curval $argv[3]
    set -l defval $argv[4]
    set -l pmpt (sc w)\n
    set -l pmpt $pmpt$desc\n
    if test "$defval"
        set pmpt $pmpt(sc b)"Default = "$defval\n
    end
    set -l pmpt $pmpt(sc y)\$$pname:' '
    # Check if the value is already set
    # If not, ask for it
    if test -z "$curval"
        read -P "$(echo -e $pmpt)" curval
    end
    # Check again, if still not set, check for default
    # Or try again
    if test -z "$curval"
        if test "$defval"
            echo "$defval"
            return 0
        end
        param $argv
    end
    echo $curval
end
