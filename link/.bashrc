[ -n "$PS1" ] && source ~/.bash_profile

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Atlassian security config
shopt -s histappend
export HISTFILESIZE=1048576
export HISTSIZE=1048576
export HISTTIMEFORMAT="%s "
export HISTCONTROL=ignoredups
# Keep noise out of history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date"

# An unclean SSH/tmux disconnect can leave the local terminal stuck in mouse
# tracking, focus reporting, or bracketed paste mode (clicks then show up as
# garbage like ^[[I^[[O). Turn those off on every prompt so it self-heals
# instead of needing a manual `reset`. Skipped inside tmux itself so we don't
# fight a live session's own mode requests.
reset_terminal_modes() {
    [ -z "$TMUX" ] && printf '\e[?1000l\e[?1002l\e[?1003l\e[?1004l\e[?1006l\e[?2004l'
}
export PROMPT_COMMAND="history -a; history -c; history -r; reset_terminal_modes${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

[ -r ~/.afm-git-configrc ] && source ~/.afm-git-configrc
