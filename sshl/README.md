# SSHL

A small utility to ssh into a local (192.168.1.*) device.

## Sourcing

To use the `:sshl` command you must first source this file: 

```sh
source sshl.fish
:sshl 18
```

## Usage

### Login to a local device

```fish
# Log in to 192.168.1.12
:sshl 12
```

### Execute a command on a local device

```fish
# Run ls on 192.168.1.18
:sshl 18 ls
r``
