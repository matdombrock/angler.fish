#!/usr/bin/env fish

# Check for argument
if test (count $argv) -lt 1 -o (count $argv) -gt 2
    echo "Usage: (basename (status -f)) <user@host> [remote_dir]"
    exit 1
end

set target $argv[1]
set remote_dir "/"
if test (count $argv) -eq 2
    set remote_dir $argv[2]
end

# Extract host part after '@'
set host (string split -m1 "@" $target)[2]
# Remove everything after the first dot for the directory name
set dir (string split -m1 "." $host)[1]
set mountpoint $HOME/$dir

# Check if sshfs is installed
if not type -q sshfs
    echo "Error: sshfs is not installed. Please install it and try again."
    exit 1
end

# Unmount if already mounted
if mountpoint -q $mountpoint
    echo "Unmounting existing sshfs mount at $mountpoint..."
    fusermount -u $mountpoint
end

# Create mountpoint if it doesn't exist
if not test -d $mountpoint
    echo "Creating mountpoint: $mountpoint"
    mkdir -p $mountpoint
    if not test -d $mountpoint
        echo "Error: Failed to create mountpoint directory $mountpoint"
        exit 1
    end
end

# Mount via sshfs (use specified remote_dir or default to /)
echo "Mounting $target:$remote_dir to $mountpoint..."
sshfs $target:$remote_dir $mountpoint

# Confirm by listing contents
echo "Contents of $mountpoint:"
ls $mountpoint
