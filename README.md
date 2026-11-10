# angler.fish

A *stream*lined shell framework for humans who still actually use computers. Made with <3 by other humans.

A tool for building a library of friendly front-ends for stuff you want your computer to do.

## Features

- Automatic documentation
    - The documentation and source are essentially the same thing
    - A docs.md is automatically generated on each build
- Automatic fuzzy launcher
    - All commands are available in the launcher with no extra setup
- Ensure required programs are installed before running tools
    - You can safely depend on `bat`
- Use "smart" parameter handling (a thing I made up but its cool)
    - Stop worrying about param handling
    - Missing params are handled automatically
- Easy default parameters
    - Missing params fall back to defaults with no extra code
- Proper lazy loading
    - Nothing is loaded until you need it
    - Even core libraries
- User commands
    - Add your own commands outside of the git repo

### Planned

- Ensure env vars are set
- Command aliases
    - Shortcut names for registered commands
- Black/white list commands from build
    - Control what gets built
- Support multiple requirements on a single line
- Support multiple commands per sub dir
- Support multiple commands per file
- World domination
    - Or maybe just shell domination?
    - We'll see where it goes

## Status

Alpha - Things will break, don't build on this yet!

---

## Use

### Install

```fish
fish angler.fish
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

---

## The `cmd.md` File Spec

```
# cmd_name

description text

$param1 the first param

$param2=3 the second param with a default value of 3

! req_cmd

`some_cmd $param1 $param2`

```

### Command Name `# *`

- Matching `# *`
- Required
- One per file
- Defines the name of the command
- Must be a valid command name

### Code (backtick) 

- Matching `[backtick]string[backtick]`
- Required
- A line starting and ending with a backtick is treated as the code which will be executed by the wrapper
- Params may be injected at any point in the command string
- One per file

### Description

- Matching no other condition (normal line)
- Required
- Lines beginning with no special characters are treated as description lines
- Currently one per file

### Parameters `$*`

- Matching `$*`
- Optional
- Parameters may have a description after the param name
- The param line may NOT contain `:` anywhere in the line
    - This includes the name of the param
- Default params are defined like `$param=123`
    - Default param values currently can not contain spaces (even wrapped in quotes)
- Expanded params (fish `argv[1..]`) are defined like `$param...` 
    - Attempting to expand multiple params is an error
    - Expanded params can can also have default values `$param...=1`
    - Expanded params should NOT include the `...` suffix when used in the code block
- Must be a valid fish param name
    - With the exception of `...`

### Requirement `! *`

- Matching `! *`
- Optional
- This is used to ensure a given program is installed and in `$PATH` before continuing

---

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

### Compiled Files

All:

- Files in a sub dir matching the name `cmd.md`
- Files in the top level matching the pattern `*.cmd.md`

Are compiled into fish wrapper functions.

They are automatically prefixed with `:`.

---

## Library Usage

You can find the core library files in `./lib`, these are available automatically to every other command. 

Just call the relevant function, no need to source anything.

For example, to get one character of input in your script, do:

```fish
set res (input.char "Choose a char")
echo $res
```

---

## User Commands

You can put your own private user commands in `./cmds_user/`. 

These will be built when `angler.fish` is run in the same was we build the commands in `./cmds/`.

The files in this directory are not tracked by git. 

---

## Programs vs Scripts

What's the line between a "program", "script" and "command"? 

The short answer is "nothing really". Its a continuum and a matter of scale. 

When exactly does a command turn into a script? Is it when it has multiple lines?

When exactly does a script turn into a program? Is it when it has multiple files? Error handling?

For the purposes of `angler.fish`, there is no distinction. Instead we have the concept of a 'wrapper' which is an interface intended for humans to use directly. No AI, not (really) other scripts. Other things can use these, if you want them to, but ultimately they are intended to be used by humans. 

A 'wrapper' must be expressed as a single line of fish. Anything more complex that that is... something else, and it belongs in a supplementary file.
