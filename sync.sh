#!/usr/bin/env bash
# Tweak file globbing.
shopt -s dotglob

cd "$(dirname "${BASH_SOURCE}")"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Update path to dotfiles
sed '3s#.*#export DOTFILES='$DIR'#' link/.bash_profile

# Save everythong on ~/.ssh folder
cp ~/.ssh/* ./link/.ssh/

# Synlink all files in "link" directory
for file in $DIR/link/*; do
    ln -sf "$file" "$HOME/${file##*/}"
done
unset file

# Copy atom icon
if [[ "$OSTYPE" == "darwin"* ]]; then
    cp -f misc/atom.icns /Applications/Atom.app/Contents/Resources/atom.icns
fi
