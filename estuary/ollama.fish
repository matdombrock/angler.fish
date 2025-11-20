# Requires jq

set prompt "$argv"
if test -z "$prompt"
    exit 1
end

set server $OL_SERVER
if test -z "$server"
    set server http://192.168.1.18:11434
end

set model $OL_MODEL
if test -z "$model"
    set model gemma3:4b
end

echo -n Not really thinking...

set res (curl -s $server/api/generate \
  -d '{
  "model": "'$model'",
  "prompt": "'$prompt'",
  "stream": false
}')

# Reset cursor position to the beginning of the current line
printf "\r"

echo $res | jq -r '.response'
