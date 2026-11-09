# angler.fish

A stream-lined shell framework for humans.

## Status

Alpha - Things will break, don't build on this yet!

## Use

### Install

```fish
fish angler.fish cmds
fish install.fish
```

### List commands

```fish
:lscmds
```

## Uninstall

```fish
fish uninstall.fish
```

## Cmds Structure

```
./cmds
    <cmd_name>/
        cmd.md
        <README.md?>
        <resource?>.*
    <cmd_name>.cmd.md 
```

### Copied Files

Currently the *entire* `./cmds` dir is copied to `~/.config/fish/functions/:ang` when you run `install.fish`. In the future, there may be a more elegant solution.

You can access all of your resources as needed by referencing this path.

### Converted Files


All:

- Files in a sub dir matching the name `cmd.md`
- Files in the top level matching the pattern `*.cmd.md`

Are converted into wrapper functions.

They are automatically prefixed with `:`.

