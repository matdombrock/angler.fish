#!/usr/bin/env fish
set here (path dirname (realpath (status filename)))
podman build -t angler -f $here/Containerfile (path dirname $here)
