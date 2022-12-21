#!/usr/bin/env bash
shopt -s dotglob

cd "$(dirname "${BASH_SOURCE}")"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Update path to dotfiles
echo "export DOTFILES=$DIR
export LOCAL_USERNAME=\"$USER\"" > link/.dotfiles

# Synlink all files in "link" directory
for file in $DIR/link/*; do
    ln -sfF "$file" "$HOME/"
done
unset file

# link nvim config
ln -sf "$DIR/nvim" "$HOME/.config/nvim"

# link nvim config
ln -sf "$DIR/starship.toml" "$HOME/.config/starship.toml"
