# chmod_dir

Make all files in a dir accessible

$dir=. directory to update

! fd

`fd --type f '.\fish$' $dir --exec chmod +x`
