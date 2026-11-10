#!/usr/bin/env fish
podman run -it --rm \
    --replace \
    --name angler \
    -v .:/angler \
    angler
