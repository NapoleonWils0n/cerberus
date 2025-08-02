# --- Bash Completion Code ---
_ollama_get_models() {
  ollama list | tail -n +2 | awk '{print $1}'
}

_ollama_completion() {
  local current_word="${COMP_WORDS[COMP_CWORD]}"
  local prev_word="${COMP_WORDS[COMP_CWORD-1]}"

  # The full list of ollama subcommands
  local subcommands="serve create show run stop pull push list ps cp rm help"

  # Case 1: The user is typing a subcommand after 'ollama'
  if [[ "${COMP_CWORD}" -eq 1 ]]; then
    COMPREPLY=($(compgen -W "${subcommands}" -- "$current_word"))
    return 0
  fi

  # Case 2: The user is typing a model name
  # This covers commands that operate on a single model.
  local model_commands="run pull push show stop rm cp create"
  if [[ "${COMP_CWORD}" -gt 1 && " ${model_commands} " =~ " ${prev_word} " ]]; then
    local models
    models=($(_ollama_get_models))
    COMPREPLY=($(compgen -W "${models[*]}" -- "$current_word"))
    return 0
  fi
}

complete -F _ollama_completion ollama
# --- End Bash Completion Code ---
