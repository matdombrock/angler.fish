#! /usr/bin/env fish
source (dirname (realpath (status --current-filename)))/llm.core.fish

set prompt (string join " " $argv)
set res (chat 20.0 $prompt)
echo $res
