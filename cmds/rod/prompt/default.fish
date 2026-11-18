function _fish_prompt
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
