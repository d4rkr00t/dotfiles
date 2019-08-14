#!/usr/bin/env bash
npm update

pkgs=(
    hicat
    imageoptim-cli
    is-up
    live-server
    ngrok
    npm-check-updates
    pmm
    pure-prompt
    recursive-blame
    svgexport
    svgo
    vtop
    yo
    yarn
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    npm i -g $pkg
done
