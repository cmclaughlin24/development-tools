#!/usr/bin/env bash

# Symlink Configuration 
if [[ ! -L ~/.config/aerospace ]]; then
  ln -s "$PWD/config/aerospace" ~/.config/aerospace
fi

if [[ ! -L ~/.config/ghostty ]]; then
  ln -s "$PWD/config/ghostty" ~/.config/ghostty
fi

if [[ ! -L ~/.config/nvim ]]; then
  ln -s "$PWD/config/nvim" ~/.config/nvim
fi

if [[ ! -L ~/.zshrc ]]; then
  ln -s "$PWD/config/.zshrc" ~/.zshrc
fi

if [[ ! -L ~/.tmux.conf ]]; then
  ln -s "$PWD/config/.tmux.conf" ~/.tmux.conf
fi
