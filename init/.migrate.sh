#!/usr/bin/env bash
#
# One-off cleanup for a machine that was set up from the old layout
# (rc files and git config in link/, workmux, tpm).
# Run after `git pull && ./setup.sh`. Safe to rerun.

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

# Dangling symlinks into this repo: old link/ targets, workmux config.
for link in "$HOME"/.[!.]* "$HOME"/.config/* "$HOME"/.config/*/*; do
    [ -L "$link" ] && [ ! -e "$link" ] || continue
    case "$(readlink "$link")" in
        "$DIR"/*) echo "removing dangling symlink $link"; rm "$link" ;;
    esac
done
rmdir "$HOME/.config/workmux" 2> /dev/null

# tpm and its plugins, replaced by native tmux clipboard bindings.
if [ -d "$HOME/.tmux/plugins" ]; then
    echo "removing $HOME/.tmux/plugins"
    rm -rf "$HOME/.tmux/plugins"
    rmdir "$HOME/.tmux" 2> /dev/null
fi

if command -v brew > /dev/null && brew list workmux > /dev/null 2>&1; then
    brew uninstall workmux
    brew untap raine/workmux
fi

# workmux status hooks fail on every agent event once the binary is gone.
for file in "$HOME/.claude/settings.json" "$HOME/.codex/hooks.json"; do
    grep -q workmux "$file" 2> /dev/null || continue
    echo "removing workmux hooks from $file (backup: $file.bak)"
    cp "$file" "$file.bak"
    jq 'if .hooks then .hooks |= (
            map_values(
                map(.hooks |= map(select((.command // "") | test("workmux") | not)))
                | map(select(.hooks | length > 0)))
            | with_entries(select(.value | length > 0)))
        else . end' "$file.bak" > "$file.tmp" && mv "$file.tmp" "$file"
done

if tmux list-sessions > /dev/null 2>&1; then
    echo "tmux server is running: old key bindings stay until it restarts (tmux kill-server)"
fi
