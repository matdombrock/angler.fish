## this dir

```fish
echo (path dirname (status filename))
echo (path dirname (realpath (status filename)))
```

## here
```fish
set here (path dirname (realpath (status filename)))
```


## unsource fns:
```
functions -e myfn
```

## test if installed:

```
if test (which cat 2>/dev/null); echo installed; else echo missing end;
```

```
function whicher
    set cmd $argv[1]
    if test -z (which "$cmd" >/dev/null)
        echo $cmd not found!
        echo If you think this program is actually installed, ensure its in $PATH, and matches the exact name \'$cmd\'
        echo If the program is installed under another name, make an alias for $cmd
        exit 1
    end
end
    
```
