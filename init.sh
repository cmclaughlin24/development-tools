#!/usr/bin/env bash

# Install Homebrew
if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

# Add Additional Repositories (Taps)
# TAPS=("isen-ng/dotnet-sdk-versions")
#
# for TAP in "${TAPS[@]}"; do
#     if ! brew tap | grep -q "^$TAP\$"; then
#         echo "$TAP is not tapped, tapping now..."
#         brew tap $TAP
#     else
#         echo "$TAP is already tapped"
#     fi
# done

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
        echo "$FORMULA is already installed"
    fi
done

# Install Homebrew Casks
CASKS=(
    "aerospace"
    "docker"
    # "dotnet-sdk8"
    # "dotnet-sdk8-0-400"
    "finch"
    "ghostty"
    "insomnia"
    "redis-insight"
    "visual-studio-code"
)

for CASK in "${CASKS[@]}"; do
    if ! brew list --cask $CASK &>/dev/null; then
        echo "$CASK is not installed, installing now..."
        brew install --cask $CASK
    else
        echo "$CASK is already installed"
    fi
done

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Oh My Zsh is not installed, installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed"
fi

# Symlink Configuration
SYMLINKS=(
    "$PWD/config/aerospace:~/.config/aerospace"
    "$PWD/config/ghostty:~/.config/ghostty"
    "$PWD/config/nvim:~/.config/nvim"
    "$PWD/config/.zshrc:~/.zshrc"
    "$PWD/config/.p10k.zsh:~/.p10k.zsh"
    "$PWD/config/.tmux.conf:~/.tmux.conf"
)

for SYMLINK in "${SYMLINKS[@]}"; do
    SOURCE=$(echo "$SYMLINK" | cut -d':' -f1)
    TARGET=$(echo "$SYMLINK" | cut -d':' -f2)

    # NOTE: Need to expand ~ to the user's home directory (cases where ~ may not be
    # interpreted correctly).
    TARGET="${TARGET/#~/$HOME}"

    if [[ ! -L "$TARGET" ]]; then
        echo "Creating symlink: $TARGET -> $SOURCE"
        ln -s "$SOURCE" "$TARGET"

        # NOTE: Special cases for sourcing configuration files.
        if [[ "$TARGET" == "$HOME/.zshrc" ]]; then
            source "$TARGET"
        elif [[ "$TARGET" == "$HOME/.tmux.conf" ]]; then
            tmux source "$TARGET"
        fi
    else
        echo "Symlink already exists: $TARGET"
    fi
done
