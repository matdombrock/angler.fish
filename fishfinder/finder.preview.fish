set exit_str $argv[1]
set goto_str $argv[2]
set back_str $argv[3]
set up_str $argv[4]
set explode_str $argv[5]
set unexplode_str $argv[6]
set ff_kb_txt $argv[7]
set ff_kb_path $argv[8]
set file_viewer $argv[9]
set selection $argv[10]

function tip
    echo (set_color brgreen) command(set_color normal):
    echo (set_color bryellow)$argv(set_color normal)
end
# Since we use the -F flag on ls we might have a trailing asterisk
set clean_sel (echo $selection | string replace "*" "")
if test $selection = $exit_str
    tip "Exit back to the shell"
    echo ""
    set_color brblue
    echo " Keybinds:"
    echo -e "$ff_kb_txt" | string trim
    set_color brgreen
    echo "modify at:"
    set_color brcyan
    echo "$ff_kb_path"
else if test "$selection" = "$goto_str"
    tip "Go to a directory (cd)"
else if test "$selection" = "$back_str"
    tip "Go back to previous directory (cd -)"
else if test "$selection" = "$up_str"
    tip "Go up one directory (cd ..)"
else if test "$selection" = "$explode_str"
    tip "Explode current directory (find . -type f)"
else if test "$selection" = "$unexplode_str"
    tip "Unexplode current directory"
else if test -f $clean_sel
    echo (set_color --bold bryellow) file(set_color normal):
    eval "$file_viewer $clean_sel"
else if test -d $clean_sel
    echo (set_color --bold brred) directory(set_color normal):
    ls --group-directories-first -A1 -F --color=always $clean_sel 2>/dev/null
else if test -L $clean_sel
    echo (set_color --bold bryellow)symlink(set_color normal):
    ls -l --color=always $clean_sel 2>/dev/null
else if test -e $clean_sel
    echo (set_color --bold bryellow)other(set_color normal):
    ls -l --color=always $clean_sel 2>/dev/null
else if test -S $clean_sel
    echo (set_color --bold bryellow)socket(set_color normal):
    ls -l --color=always $clean_sel 2>/dev/null
else if test -p $clean_sel
    echo (set_color --bold bryellow)pipe(set_color normal):
    ls -l --color=always $clean_sel 2>/dev/null
else if test -b $clean_sel
    echo (set_color --bold bryellow)block device(set_color normal):
    ls -l --color=always $clean_sel 2>/dev/null
else if test -c $clean_sel
    echo (set_color --bold bryellow)character device(set_color normal):
    ls -l --color=always $clean_sel 2>/dev/null
else if test -d $clean_sel = false and test -f $clean_sel = false
    echo (set_color --bold bryellow)non-standard file type(set_color normal):
    ls -l --color=always $clean_sel 2>/dev/null
else
    echo No preview available.
    echo $clean_sel
    echo $selection
end
