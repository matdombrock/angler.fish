# ollama-ls

Usage: ollama-ls.fish <sort-metric|filter-string>
Sort and filter the output of 'ollama ls' based on the specified options.

Metrics:
  size        Sort by model size.
  name        Sort by model name alphabetically.
  modified    Sort by last modified date.
  help        Display this help message.

Filter:
  If no metric is supplied, treat the input as a filter string to match lines in the output.
