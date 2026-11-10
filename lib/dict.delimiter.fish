set -q ANG_DL_DICT; or set -gx ANG_DL_DICT "="

# In some cases, you might want to use a different delimiter
# for example if your values contain '=' characters
# Set the delimiter between key and value
function dict.delimiter
    set -gx ANG_DL_DICT $argv[1]
end
