#!/usr/bin/env bash
npm update

pkgs=(
    aik
    commitizen
    csscomb
    eslint
    generator-np
    greenkeeper
    gulp
    hicat
    imageoptim-cli
    is-up
    live-server
    ngrok
    npm-check-updates
    peerflix
    pmm
    svgexport
    svgo
    vtop
    yo
)

for pkg in "${pkgs[@]}"; do
    echo "Installing $pkg"
    npm i -g $pkg
done
