#!/usr/bin/env bash

# Install Homebrew
if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew Formulae
FORMULAE=(
    "fzf" 
    "go" 
    "helm" 
    "jq" 
    "kubernetes-cli" 
    "lazygit" 
    "minikube" 
    "neovim" 
    "node" 
    "powerlevel10k"
    "ripgrep"
    "tmux"
    "zig"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

for FORMULA in "${FORMULAE[@]}"; do
    if ! brew list $FORMULA &>/dev/null; then 
        echo "$FORMULA is not installed, installing now..."
        brew install $FORMULA
    else
        echo "$FORMULA is already installed."
    fi
done

# Install Homebrew Cask
CASKS=(
    "aerospace"
    "ghostty"
)

for CASK in "${CASKS[@]}"; do
    if ! brew list --cask $CASK &>/dev/null; then 
        echo "$CASK is not installed, installing now..."
        brew install --cask $CASK
    else
        echo "$CASK is already installed."
    fi
done

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
