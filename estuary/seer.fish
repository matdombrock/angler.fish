# Seer is a terminal file explorer using fzf for selection and previewing files.
# It allows navigation through directories and opening files with the default editor.

function seer
    # Check for fzf
    if not type -q fzf
        echo "This program requires `fzf`!" && exit 1
    end

    # Set up fzf
    # Force this to use fish or it will use the default shell which may not be fish
    # This could also be done by just writing it as posix sh
    set file_viewer cat
    if type -q bat
        set file_viewer 'bat --plain --color=always'
    end
    set fzf_preview 'fish -c "
    if test -f {}; 
        echo file:
        '$file_viewer' {}; 
    else if test -d {}; 
        echo directory:
        ls -a {}; 
    else; 
        echo \"Not a file or directory\"; 
    end
"'
    set fzf_options "--prompt=$(prompt_pwd)/" --ansi --layout=reverse --height=80% --border \
        --preview="$fzf_preview {}" --preview-window=right:60%:wrap

    set exit_msg '📁 exit'
    set home_msg '~/'
    set up_msg '.. up'

    # Define a helper function to list files with special entries
    function ls+
        # Since these vars should not be gloabal, we must pass them as args
        set exit_msg $argv[1]
        set home_msg $argv[2]
        set up_msg $argv[3]
        set_color yellow
        echo $exit_msg
        echo $home_msg
        set_color green
        echo $up_msg
        set_color normal
        ls --group-directories-first -A1
    end

    # Get the selection
    set sel (ls+ $exit_msg $home_msg $up_msg | fzf $fzf_options)

    # Check if sel is null or empty
    if test -z "$sel"
        echo No selection made. Exiting seer.
        echo (pwd)
        return
    end

    # Handle exit
    if test "$sel" = "$exit_msg"
        echo Exiting seer.
        echo (pwd)
        return
    end

    # Handle home directory
    if test "$sel" = "$home_msg"
        cd ~
        seer
        return
    end

    # Handle up directory
    if test "$sel" = "$up_msg"
        cd ..
        seer
        return
    end

    # Handle file or directory
    if test -d "$sel"
        cd $sel
        seer
        return
    else if test -f $sel
        if set -q VISUAL
            $VISUAL $sel
        else if set -q EDITOR
            $EDITOR $sel
        else
            less $sel
        end
    end
end

# Run seer if the script is being executed directly
if not test "$_" = source
    seer
end
