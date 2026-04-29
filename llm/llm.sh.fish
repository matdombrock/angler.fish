#! /usr/bin/env fish
source (dirname (realpath (status --current-filename)))/llm.core.fish

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
    set res_override $argv[3]
    set -l res (chat "$argv[1]" "$argv[2]")

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
