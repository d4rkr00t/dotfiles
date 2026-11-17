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

# Shell rc files in $HOME are untracked stubs that source the repo files, so
# tools appending to ~/.zshrc and friends never modify the repo.
stub() {
    [ -L "$1" ] && rm "$1"
    [ -e "$1" ] || echo "$2" > "$1"
}
stub "$HOME/.zshrc" "source \"$DIR/rc/zshrc\""
stub "$HOME/.bashrc" "source \"$DIR/rc/bashrc\""
stub "$HOME/.bash_profile" 'source ~/.bashrc'

mkdir -p "$HOME/.config/git" "$HOME/.claude" "$HOME/.codex"

# Git reads ~/.config/git/config as well as ~/.gitconfig; the latter stays a
# local untracked file for machine-specific settings.
ln -sfn "$DIR/git/config" "$HOME/.config/git/config"
ln -sfn "$DIR/git/ignore" "$HOME/.config/git/ignore"
# must exist, otherwise `git config --global` writes into the tracked file
stub "$HOME/.gitconfig" "# machine-local git config, not tracked"
[ -L "$HOME/.gitignore" ] && rm "$HOME/.gitignore"

# link nvim config
ln -sfn "$DIR/nvim/" "$HOME/.config/"

# link skills
ln -sfn "$DIR/skills/" "$HOME/.claude/skills"
ln -sfn "$DIR/skills/" "$HOME/.codex/skills"

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
