#!/usr/bin/env bash
npm update

pkgs=(
    babel-eslint
    caniuse-cmd
    cloc
    commitizen
    csscomb
    eslint
    generator-np
    gulp
    hicat
    how2
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
