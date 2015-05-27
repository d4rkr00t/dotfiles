#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

while read f; do
    ln -sf "$DIR/$f" "$HOME/$f"
done < .sync-list

if [[ "$OSTYPE" == "darwin"* ]]; then
    cp -f atom.icns /Applications/Atom.app/Contents/Resources/atom.icns
fi
