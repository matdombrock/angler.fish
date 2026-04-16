# EZSSHFS

A simple script to mount a remote filesystem via sshfs
Usage:
```fish
./ezsshfs.fish user@host [remote_dir]
```

If the mount gets stuck use:
fusermount -uz $HOME/<mountpoint>
