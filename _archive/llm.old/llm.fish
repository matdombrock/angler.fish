#! /usr/bin/env fish

source (dirname (realpath (status --current-filename)))/../_lib/input.fish
source (dirname (realpath (status --current-filename)))/llm.core.fish
source (dirname (realpath (status --current-filename)))/llm.chatui.fish

set model $LLM_MODEL
if test -z "$model"
    set_color yellow
    echo "No \$LLM_MODEL set, defaulting to gemma3:4b"
    echo "To set:"
    set_color blue
    echo "set -x LLM_MODEL https://localhost:11434"
    set model gemma3:4b
end
set server $LLM_SERVER
if test -z "$server"
    set_color yellow
    echo "No \$LLM_SERVER set, defaulting to http://localhost:11434"
    echo "To set:"
    set_color blue
    echo "set -x LLM_MODEL gemma3:4b"
    set server http://localhost:11434
end

#
# Utility functions
#

function sysinfo
    echo -n $(whoami)@$(hostname) - \
        $(cat /etc/*-release | \
        grep PRETTY_NAME | \
        sed -e 's/PRETTY_NAME=//' -e 's/"//g')
    echo -n " | Kernel: " (uname -r)
    echo -n " | CPU: " (lscpu | grep "Model name" | sed -e 's/Model name:[ \t]*//')
    echo -n " | Memory: " (free -h | grep "Mem:" | awk '{print $2}')
    echo -n " | Disk: " (lsblk -d -o NAME,SIZE | grep -v NAME | awk '{print $1 ": " $2}')
    echo -n " | Uptime: " (uptime -p)
    echo -n " | Shell: " $SHELL
end

function echollm
    set -l opts $argv
    set -l res (ollama_completion $opts)
    echo -e $res | string trim
end

#
# Command functions
#

# List all models using fzf for selection
# Uses the api/tags endpoint to get model info
# curl http://localhost:11434/api/tags | jq -r '.models[] | "\(.name) \(.details.parameter_size) \(.details.quantization_level)"'
function models
    function model_lines
        set -l list $argv
        set -l listr (echo $list | jq -r '.models[] | "\(.name) \(.details.parameter_size) \(.details.quantization_level)"')
        for line in $listr
            set -l line_split (echo $line | string split ' ')
            set -l model_split (echo $line_split[1] | string split ':')
            set -l model_name $model_split[1]
            set -l model_tag $model_split[2]
            set_color green
            echo -n $model_name
            set_color blue
            echo -n ":"
            set_color magenta
            echo -n "$model_tag"
            set_color blue
            echo -n " - "
            set_color yellow
            echo -n $line_split[2]
            set_color cyan
            echo -n " "
            echo $line_split[3]
        end
    end
    set -l listopts server="$server"
    set -l list (ollama_list_models $listopts)
    set -l selection (model_lines $list | fzf --prompt="Find LLM model: " --height=40% --layout=reverse --border --ansi)
    if test -z "$selection"
        set_color yellow
        echo "No model selected."
        return
    end
    set -l model_name (echo $selection | string split ' ')[1]
    set_color magenta
    echo "Current model: $model"
    set_color green
    echo "To set model, run:"
    set_color blue
    echo "set -x LLM_MODEL $model_name"
end
# Alias for models
# function list
#     models
# end
# function ls
#     models
# end

function com
    set -l opts \
        prompt="$argv" \
        system="You are a helpful AI assistant." \
        model="$model" \
        server="$server"
    echollm $opts
end

function cmd
    set -l dir_listing (ls | string join '\n')
    set -l opts \
        prompt="$argv" \
        system="\
The user will request a unix command in natural language.\
You will respond only with a valid, full unix command that fulfils the user's request.\
Do not use markdown or code blocks.\
Your response will be executed directly in the user's terminal.\
User's system information: $(sysinfo). \
User's pwd: $(pwd). \
User's current directory listing: '$dir_listing'. \
" \
        model="$model" \
        server="$server" \
        temperature=0.2
    echollm $opts
end

function chat
    set -l opts \
        model="$model" \
        system="$argv" \
        server="$server" \
        temperature=0.7 \
        seed=-1
    chatui $opts
end

if test -z "$argv"
    echo "Usage: llm <command> [args...]"
    echo "Commands:"
    echo "  set-model           Interactively set the LLM model."
    echo "  set-server <url>    Set the LLM server URL."
    echo "  com <prompt>        Get a completion for the given prompt."
    echo "  cmd <description>   Get a unix command for the given description."
    echo "  chat <system>       Start an interactive chat session."
    exit 1
end

eval $argv[1] $argv[2..-1]
