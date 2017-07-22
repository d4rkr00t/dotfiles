#!/usr/bin/env bash
npm update

pkgs=(
    aik
    commitizen
    csscomb
    eslint
    hicat
    imageoptim-cli
    is-up
    live-server
    ngrok
    npm-check-updates
    peerflix
    pmm
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
