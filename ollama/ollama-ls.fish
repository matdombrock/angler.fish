#!/usr/bin/env fish

# A simple CLI wrapper for sorting the `ollama ls` output and filtering results.

function usage
    echo "Usage: ollama-ls.fish <sort-metric|filter-string>"
    echo "Sort and filter the output of 'ollama ls' based on the specified options."
    echo
    echo "Metrics:"
    echo "  size        Sort by model size."
    echo "  name        Sort by model name alphabetically."
    echo "  modified    Sort by last modified date."
    echo "  help        Display this help message."
    echo
    echo "Filter:"
    echo "  If no metric is supplied, treat the input as a filter string to match lines in the output."
end

if test (count $argv) -lt 1
    usage
    exit 1
end

set input $argv[1]
set filter ""

# Determine if the input is a known metric or a filter string
if test $input = "size"
    set metric "size"
else if test $input = "name"
    set metric "name"
else if test $input = "modified"
    set metric "modified"
else if test $input = "help"
    usage
    exit 0
else
    set filter $input
    set metric "name"  # Default to name sorting when input is a filter string
end

# Run ollama ls and conditionally filter the output
function run_and_filter
    set command "ollama ls"
    if test -n "$filter"
        set command "$command | rg --ignore-case -- $filter"
    end
    eval $command
end

switch $metric
    case "size"
        echo "Filtering and sorting ollama ls output by size..."
        run_and_filter | sort -hk3
    case "name"
        echo "Filtering and sorting ollama ls output by name..."
        run_and_filter | sort -k1
    case "modified"
        echo "Filtering and sorting ollama ls output by modified time..."
        run_and_filter | sort -k4
end