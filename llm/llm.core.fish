#! /usr/bin/env fish

# Requires jq

source (dirname (realpath (status --current-filename)))/../_lib/dict.fish
# dict.delimiter "===DICT_DELIM==="

# Helper function to get option or default value
function opt_or
    set -l key $argv[1]
    set -l default $argv[2]
    set -l option $argv[3..-1]
    set -l value (dict.get $key $option)
    if test $value = null
        if test $default = exit
            echo "Error: $key is required" >&2
            exit 1
        end
        echo $default
    else
        echo $value
    end
end

# opts:
# prompt (required)
# model (required)
# server (default: http://localhost:11434)
# system (default: You are a helpful assistant)
# seed (default: -1)
# temperature (default: 0.7)
function ollama_completion
    set -l opts $argv

    set -l prompt (opt_or prompt exit $opts)
    set -l model (opt_or model exit $opts)
    set -l server (opt_or server "http://localhost:11434" $opts)
    set -l system (opt_or system "You are a helpful assistant" $opts)
    set -l seed (opt_or seed -1 $opts)
    set -l temperature (opt_or temperature 0.7 $opts)

    set -l res (\
curl -s $server/api/generate \
  -d '{
  "model": "'$model'",
  "prompt": "'$prompt'",
  "system": "'$system'",
  "options": {
    "seed": '$seed',
    "temperature": '$temperature'
  },
  "stream": false
}')

    set -l res (echo $res | jq -r '.response')
    echo -e $res
end

# opts:
# model (required)
# messages (required) - JSON array string
# server (default: http://localhost:11434)
# system (default: You are a helpful assistant)
# seed (default: -1)
# temperature (default: 0.7)
#
# messages should be a JSON array string, e.g. 
# '[{"role":"user","content":"Hello"}]'
function ollama_chat
    set -l opts $argv

    set -l model (opt_or model exit $opts)
    set -l messages (opt_or messages exit $opts)
    set -l server (opt_or server "http://localhost:11434" $opts)
    set -l system (opt_or system "You are a helpful assistant" $opts)
    set -l seed (opt_or seed -1 $opts)
    set -l temperature (opt_or temperature 0.7 $opts)

    set -l payload (string join '' '
    {
      "model": "'$model'",
      "messages": '$messages',
      "options": {
        "seed": '$seed',
        "temperature": '$temperature'
      },
      "stream": false
    }')
    curl -s $server/api/chat -d "$payload" | jq -r '.message.content'
end
