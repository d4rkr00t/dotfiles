#!/usr/bin/env bash
npm update

pkgs=(
  pure-prompt
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    npm i -g $pkg
done
