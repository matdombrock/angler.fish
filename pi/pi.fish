#!/usr/bin/env fish

function pi_chat
    pi \
        --no-extensions -e ~/.pi/agent/extensions/web-tools -e ~/.pi/agent/extensions/lmstudio-remote \
        --tools web_fetch,web_search \
        --no-skills \
        --system-prompt "You are a helpful assistant named r33! You have a web_search and a web_fetch tool."
end

function pi_cli
    if test (count $argv) -lt 1
        echo "Usage: pi cli <command_description>"
        exit 1
    end
    pi \
        --no-extensions \
        --no-tools \
        --no-skills \
        --system-prompt "Respond only with the linux command described by the user." \
        -p "$argv[1]"
end

function pi_quick
    if test (count $argv) -lt 1
        echo "Usage: pi quick <question>"
        exit 1
    end
    # Join all arguments as a single string to mimic "$*"
    set -l prompt (string join ' ' $argv)
    pi \
        -ne \
        --no-extensions \
        --no-tools \
        --no-skills \
        --system-prompt "Anser this question quicly and simply. Don't over explain. Here is the question:" \
        -p "$prompt"
end

function help
    echo "Usage: pi [chat|cli|quick] [args]"
end

if test (count $argv) -eq 0
    echo "Usage: pi [chat|cli|quick] [args]"
    exit 1
end

set -l mode $argv[1]
set -e argv[1]

switch $mode
    case c
    case chat
        pi_chat $argv
    case quick
    case q
        pi_quick $argv
    case cli
        pi_cli $argv
    case -h
        help
    case '*'
        echo "Unknown mode: $mode"
        help
        exit 1
end
