TODO_CMD="todo"
TODO_STATE_FILE="$HOME/.cache/todo_last_seen"
TODO_INTERVAL=3600 # 1 hour in seconds

mkdir -p "$HOME/.cache"

todo_should_show() {
  local now last diff

  now=$(date +%s)

  if [[ -f "$TODO_STATE_FILE" ]]; then
    last=$(cat "$TODO_STATE_FILE")
  else
    last=0
  fi

  diff=$((now - last))

  [[ $diff -ge $TODO_INTERVAL ]]
}

todo_show_and_update() {
  command -v "$TODO_CMD" >/dev/null 2>&1 || return
  echo
  "$TODO_CMD"
  date +%s >"$TODO_STATE_FILE"
}

# ---- Show on terminal open ----
todo_should_show && todo_show_and_update

# ---- Show again when pressing Enter (empty command) ----
if [[ -n "$ZSH_VERSION" ]]; then
  # ZSH
  precmd_functions+=(
    todo_precmd
  )

  todo_precmd() {
    if [[ -z "$BUFFER" ]] && todo_should_show; then
      todo_show_and_update
    fi
  }
else
  # BASH
  PROMPT_COMMAND='
    if [[ -z "$BASH_COMMAND" ]] && todo_should_show; then
      todo_show_and_update
    fi
  '
fi
