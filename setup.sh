#!/usr/bin/env bash
shopt -s dotglob

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$DIR"

# Update path to dotfiles
echo "export DOTFILES=$DIR
export LOCAL_USERNAME=\"$USER\"" > link/.dotfiles

# Synlink all files in "link" directory
for file in "$DIR"/link/*; do
    echo "$file"
    ln -sfF "$file" "$HOME/$(basename "$file")"
done
unset file

# link nvim config
ln -sfn "$DIR/nvim/" "$HOME/.config/"

# link skills
mkdir -p "$HOME/.claude" "$HOME/.codex" "$HOME/.config/workmux"
ln -sfn "$DIR/skills/" "$HOME/.claude/skills"
ln -sfn "$DIR/skills/" "$HOME/.codex/skills"

# link workmux config
ln -sfn "$DIR/misc/.workmux.yaml" "$HOME/.config/workmux/config.yaml"
ln -sfn "$DIR/misc/.claude.md" "$HOME/.claude/CLAUDE.md"

# link rex config (replace an older whole-dir symlink so ln doesn't write through it)
[ -L "$HOME/.config/rex" ] && rm "$HOME/.config/rex"
mkdir -p "$HOME/.config/rex"
ln -sfn "$DIR/rex/init.lua" "$HOME/.config/rex/init.lua"

# claude status line (merged, settings.json is also written by claude and managed tooling)
settings="$HOME/.claude/settings.json"
[ -f "$settings" ] || echo '{}' > "$settings"
jq --arg cmd "$DIR/misc/claude-statusline.sh" '.statusLine = {type: "command", command: $cmd}' \
    "$settings" > "$settings.tmp" && mv "$settings.tmp" "$settings"
