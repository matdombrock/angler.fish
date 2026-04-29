#! /usr/bin/env fish
source (dirname (realpath (status --current-filename)))/llm.core.fish

set prompt (string join " " $argv)
set res (chat 0.2 $prompt)
echo $res
