#!/usr/bin/env bash
npm update

pkgs=(
    bower
    caniuse-cmd
    commitizen
    csscomb
    generator-np
    diff-so-fancy
    gulp
    hicat
    is-up
    jscs
    live-server
    ngrok
    npm-check-updates
    peerflix
    pmm
    psi
    svgexport
    svgo
    vtop
    yo
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    npm i -g $pkg
done
