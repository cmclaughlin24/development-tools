#!/usr/bin/env bash

# NOTE: To make script executable.
# chmod +x ~/.config/nvim/lua/cmclaughlin24/other/tmux-sessionizer.sh

switch_to() {
  # NOTE: If already in tmux, need to switch sessions, otherwise need to attach to sessions.
  if [[ -z "$TMUX" ]]; then
    tmux attach-session -t $1
  else
    tmux switch-client -t $1
  fi
}

hydrate() {
  tmux send-keys -t $1 "nvim ." ^M
}

selected=$(find ~/Documents -mindepth 1 -maxdepth 2 -type d | fzf)

if [[ -z "$selected" ]]; then
  exit 0;
fi

selected_name=$(basename $selected | tr ":,. " "----")

if ! tmux has-session -t=$selected_name; then
  tmux new-session -ds $selected_name -c $selected
  hydrate $selected_name
fi

switch_to $selected_name