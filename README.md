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

### Uninstall

```fish
fish uninstall.fish
```

## The `cmd.md` File Spec

```
# cmd_name

description text

$param1 the first param

$param2 the second param

! req_cmd

`some_cmd $param1 $param2`

```

### Command Name `# *`

One per file.

### Param `$*`

Params may have a description after the param name.

### Requirement `! *`

This is used to ensure a given program is installed and in `$PATH` before continuing.

### Code `\`` (backtick) 

The code which will be executed by the wrapper.

Params may be injected at any point in the command string.

### Description

Lines beginning with no special characters are treated as description lines.

Currently one per file.

## Command Source Directory Structure

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

