#!/bin/sh
MODE="${1:-clear}"
[ -z "$TMUX" ] && exit 0

WAIT_FILE="/tmp/ai_tmux_waiting"

case "$MODE" in
  waiting)
    [ -z "$TMUX_PANE" ] && exit 0
    WINDOW=$(tmux display-message -p -t "$TMUX_PANE" '#{window_id}')
    echo "$WINDOW" > "$WAIT_FILE"
    tmux set-window-option -t "$WINDOW" @ai_waiting 1
    ;;
  clear)
    [ -f "$WAIT_FILE" ] || exit 0
    WINDOW=$(cat "$WAIT_FILE")
    rm -f "$WAIT_FILE"
    tmux set-window-option -u -t "$WINDOW" @ai_waiting 2>/dev/null || true
    ;;
esac
