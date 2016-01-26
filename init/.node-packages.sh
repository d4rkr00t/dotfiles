#!/usr/bin/env bash
npm update

pkgs=(
    bower
    caniuse-cmd
    commitizen
    csscomb
    generator-np
    gulp
    hicat
    is-up
    jscs
    jshint
    live-server
    ngrok
    npm-check-updates
    peerflix
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
