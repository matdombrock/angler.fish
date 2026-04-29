#! /usr/bin/env fish
source (dirname (realpath (status --current-filename)))/llm.core.fish

set model $argv[1]
set temp $argv[2]
set prompt (string join " " $argv[3..-1])

echo "Model: $model"
echo "Temperature: $temp"
echo "Prompt: $prompt"

chat_raw $model $temp $prompt
