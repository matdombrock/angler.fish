# Source a file that exists in the relative dir
# Even if the script if being run from another dir
set script_dir (dirname $fish_source)
source $script_dir/other_file.fish

# Check if the script is being sourced or executed 
if test "$_" = source
    echo This file is being sourced
else
    echo This file is being executed
end

# Show the value of $_
echo "\$_: ""$_"

# Define a function and then erase it to demonstrate it won't be available
function no_source
    echo this function will not be available to the shell
end
functions --erase no_source
