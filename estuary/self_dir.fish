# Source a file that exists in the relative dir
# Even if the script if being run from another dir
source (dirname (status --current-filename))/../lib/dict.fish

set dt key1=value1 key2=value2 key3=value3
dict.get key2 $dt
