#! /usr/bin/env fish
source (dirname (realpath (status --current-filename)))/llm.core.fish

set -l topics "programming" "technology" "science" "history" "sports" "music" "movies" "literature" "food" "animals"

for topic in $topics
    echo "Joke about $topic:"
    set prompt "Tell me a joke about $topic."
    set res (chat 20.0 $prompt)
    echo $res
    echo ""
end
