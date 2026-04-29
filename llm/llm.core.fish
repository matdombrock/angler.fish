source (dirname (realpath (status --current-filename)))/llm.cfg.fish
# Get API key from environment

function chat
  set temp $argv[1]
  set prompt $argv[2]
  
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
  
  # Build the actual endpoint URL
  set api $url/v1/chat/completions
  # Make the request
  set -l res_raw (curl $api \
    --silent \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $api_key" \
    -d "$json")
  
  # Extract the command from the response
  set -l res (echo $res_raw | jq -r '.choices[0].message.content')

  echo $res
end
