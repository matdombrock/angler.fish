#! /usr/bin/env fish

#
# Config
#

set model nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free
set url https://openrouter.ai 

# LM Studio example:
# set url http://localhost:1234
# set model nvidia/nemotron-3-nano-4b 

# Build the actual endpoint URL
set api $url/api/v1/chat/completions

# Get API key from environment
set api_key $OPENROUTER_API_KEY

# Build the prompt
set prompt (string join " " $argv)
set prompt "
This is a description of a bash command. 
Respond only with a valid executable command. 
Your response will be run directly in the users shell. 
Description: 
$prompt
"

function run
    set temp $argv[1]
    set prompt $argv[2]
    set res_override $argv[3]
    
    set json (jq -n \
      --arg content "$prompt" \
      --arg model "$model" \
      --argjson temperature $temp \
      '{
        model: $model,
        messages: [
          {role: "user", content: $content}
        ],
        max_tokens: 8000,
        temperature: $temperature
      }'
    )
    
    set -l res (curl $api \
      --silent \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $api_key" \
      -d "$json")
    
    # Extract the command from the response
    set -l res (echo $res | jq -r '.choices[0].message.content')
    
    set_color green
    echo $res
    set_color normal

    if test -n "$res_override"
      set res "$res_override"
      echo "cmd: $res"
    end

    function pq
      echo -n (set_color cyan)'('$argv[1]')'(set_color normal)$argv[2]
    end

    set q (pq e xec)'|'(pq y ank)'|'(pq r etry)'|'(pq f ix)'|'(pq '?' explain)'|'(pq q uit)': ' 
    
    read -P $q in
    
    if test "$in" = "e"
      eval $res
    else if test "$in" = "y"
      echo $res | xclip -selection clipboard
      echo "yanked"
    else if test "$in" = "r"
      echo "trying again..."
      run 0.2 "$prompt. The user rejected the last command: $res"
    else if test "$in" = "f"
      read -P "problem: " ex
      run 0.2 "The user rejected the last command: $res\n With the reason: $ex\n $prompt"
    else if test "$in" = "?"
      run 0 "Give a simple, pain text (no markdown) explaination of the command: $res" $res
    end
end

run 0 $prompt
