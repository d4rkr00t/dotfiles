#!/usr/bin/env bash
shopt -s dotglob

cd "$(dirname "${BASH_SOURCE}")"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Update path to dotfiles
echo 'export DOTFILES='$DIR > link/.dotfiles

# Synlink all files in "link" directory
for file in $DIR/link/*; do
    ln -sfF "$file" "$HOME/"
done
unset file

# Copy atom icon
if [[ "$OSTYPE" == "darwin"* ]]; then
    cp -f misc/atom.icns /Applications/Atom.app/Contents/Resources/atom.icns
fi
