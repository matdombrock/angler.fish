#!/usr/bin/env fish

# Check for argument
if test (count $argv) -ne 1
    echo "Usage: (basename (status -f)) <user@host>"
    exit 1
end

set target $argv[1]

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

# Mount via sshfs (default to home directory)
echo "Mounting $target: to $mountpoint..."
sshfs $target: $mountpoint

# Confirm by listing contents
echo "Contents of $mountpoint:"
ls $mountpoint
