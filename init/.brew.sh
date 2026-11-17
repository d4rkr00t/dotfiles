#!/usr/bin/env bash

brew update
brew bundle --file="$(dirname "${BASH_SOURCE[0]}")/../Brewfile"
brew cleanup
