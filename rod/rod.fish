# NOTE: This file is intended to be sourced
# This is required to set the prompt style

set PROMPT full
set rod_list

# NOTE:
# Its probablly slow to define functions inside fish_prompt every time its called.
# The only reasonable alternative is to export the functions so they are available to fish_prompt
function fish_prompt
    set rod_list # Clear rod_list

    set -a rod_list full
    function full
        set -l userIcon ''
        set -l hostIcon ''
        set -l folderIcon ''
        set -l gitIcon ''
        set -l prompIcon λ
        set -l line1Icon '┌'
        set -l line2Icon '└'
        set_color brcyan
        echo -n "$line1Icon"
        set_color bryellow
        echo -n "$userIcon $(whoami)"
        echo -n " $hostIcon $(hostname)"
        echo -n " $folderIcon $(prompt_pwd)"
        set_color green
        echo -n "  $gitIcon$(fish_git_prompt)"
        set_color bryellow
        echo -n "▶"
        echo -e ""
        set_color brcyan
        echo -n "$line2Icon"
        set_color bryellow
        echo -n "$prompIcon "
        set_color normal
    end

    set -a rod_list minimal
    function minimal
        set_color bryellow
        set -l prompIcon λ
        echo -n "$prompIcon "
        set_color normal
    end

    set -a rod_list default
    function default
        set -l last_status $status
        set -l cyan (set_color cyan)
        set -l normal (set_color normal)
        set -l user (whoami)
        set -l host (hostname | cut -d . -f 1)
        set -l cwd (prompt_pwd)

        if test "$USER" = root
            set user_color (set_color red)
        else
            set user_color (set_color green)
        end

        # Print user@host in color
        echo -n -s $user_color $user $normal @ $cyan $host $normal ' '

        # Print working directory
        echo -n -s $cwd

        # Print a red '✗' if last command failed, else a green '❯'
        if test $last_status -ne 0
            set arrow_color (set_color red)
            set arrow '✗'
        else
            set arrow_color (set_color green)
            set arrow '❯'
        end

        echo -n -s ' ' $arrow_color $arrow $normal ' '
    end

    # Check if PROMPT is in rod_list
    if not contains $PROMPT $rod_list
        set_color red
        echo "Warning: PROMPT '$PROMPT' not found in rod_list. Reverting to 'default'."
        rod # Call with no args to get the list
        set_color normal
        # We cant continue without  having some kind of prompt here
        set PROMPT default
    end

    eval $PROMPT
    return
end

function :rod
    if test "$argv[1]" = list; or test "$argv[1]" = l; or test -z "$argv[1]"
        set_color brmagenta
        echo "Available prompt styles:"
        set_color brgreen
        for prompt_style in $rod_list
            echo " - $prompt_style"
        end
        return
    end
    set PROMPT $argv[1]
end

# Appease the LSP
if test 1 = 0
    fish_prompt
    :rod
end
