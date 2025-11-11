# FishFinder

FishFinder is a terminal file explorer with fuzzy searching using fzf.

# Modes:
You can enter a special mode by sending an argument to fishfinder
- No argument: Normal mode, shows files and directories in current directory
- explode: Shows all files recursively from current directory
- l: Last path mode, echoes the last selected path from fishfinder and exits

# Keybinds:
- Right Arrow: Enter directory or select file
- Left Arrow: Go up one directory
- Ctrl-V: View file or directory listing
- Ctrl-P: Print the selected file path and exit
- Ctrl-E: Execute the selected file
- Ctrl-X: Toggle explode mode (show all files recursively from current directory)
- Ctrl-D: Delete the selected file or directory with confirmation
- Alt-D:  Instantly delete the selected file or directory
- Ctrl-R: Reload the current directory listing
- : (colon): Execute a custom command on the selected file
- Shift-Up Arrow: Scroll preview up
- Shift-Down Arrow: Scroll preview down
- CTRL-Q: Quit

