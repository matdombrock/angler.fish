set PROMPT full
function fish_prompt
    if test "$PROMPT" = full
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
    else if test "$PROMPT" = minimal
        set_color bryellow
        set -l prompIcon λ
        echo -n "$prompIcon "
        set_color normal
    else
        # Default prompt
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
end

function set_prompt
    set PROMPT $argv[1]
end

# Appease the LSP
if test 1 = 0
    fish_prompt
    set_prompt
end
