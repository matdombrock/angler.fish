set -l base (dirname (realpath (status --current-filename)))/../..
add_cmd angler "FishFinder: file explorer" "$base/fishfinder/finder.fish"
add_cmd angler "Tbox: command launcher" "set TBOX_CMD_PATH $base/tbox/demo.tbox.fish && $base/tbox/tbox.fish"
add_cmd angler "Reel: fuzzy find and install packages" "$base/reel/reel.fish fish"
add_cmd angler "Fish: in fish" "$base/fishfish/fish.fish"
add_cmd angler "adventure game" "$base/games/adv.fish"

add_cmd edit "edit nvim config" "cd ~/.config/nvim && nvim"
add_cmd edit "edit fish config" "cd ~/.config/fish && nvim"

add_cmd system "list users" "cut -d: -f1 /etc/passwd"
add_cmd system "list disks" lsblk
add_cmd system "show date" date
add_cmd system "show uptime" uptime
add_cmd system "show disk usage" "df -h"
add_cmd system "show memory usage" "free -h"
add_cmd system "show processes" "ps aux"
add_cmd system "system monitor" htop
add_cmd system "where am I?" \
    "echo $(whoami)@$(hostname) - \
$(cat /etc/*-release | \
grep PRETTY_NAME | \
sed -e 's/PRETTY_NAME=//' -e 's/\"//g')"

add_cmd network "check connectivity" "ping google.com"
add_cmd network "ssh local" "ssh $(whoami)@192.168.1.{##}"

add_cmd ls "list files" "ls {#}"
add_cmd ls "list all files" "ls -a"

add_cmd git status "git status"
add_cmd git log "git log --oneline --graph --decorate"

add_cmd wttr "wttr full" "curl wttr.in {#}"
