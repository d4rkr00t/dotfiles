#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

pkgs=(
    autossh
    bash
    bash-completion
    bat
    cloc
    coreutils
    dua-cli
    entr
    eza
    fd
    ffmpeg
    findutils
    fnm
    fswatch
    fzf
    gifsicle
    git
    git-absorb
    git-lfs
    git-when-merged
    # hh
    httpie
    imagemagick
    jq
    # ncdu
    neovim
    pure
    rename
    ripgrep
    # starship
    tlrc
    tmux
    tree
    vim
    wget
    zoxide
    zsh
    zsh-completions
    zsh-history-substring-search
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    brew install $pkg
done

# Remove outdated versions from the cellar
brew cleanup

# enable fzf features
$(brew --prefix)/opt/fzf/install
