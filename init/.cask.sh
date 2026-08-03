#!/usr/bin/env bash

# Install native apps

pkgs=(
  wezterm
  numi
  obsidian

  nikitabobko/tap/aerospace
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    brew install $pkg --cask
done

brew cleanup
